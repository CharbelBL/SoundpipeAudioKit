// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import AVFoundation
import SoundpipeAudioKit
import XCTest

class ConvolutionTests: XCTestCase {
    func testConvolution() {
        let url = Bundle.module.url(forResource: "TestResources/drumloop", withExtension: "wav")!
        let engine = AudioEngine()
        let player = AudioPlayer()

        let dishURL = Bundle.module.url(forResource: "TestResources/dish", withExtension: "wav")!
        let convolution = Convolution(player,
                                      impulseResponseFileURL: dishURL,
                                      partitionLength: 8192)

        engine.output = convolution

        let audio = engine.startTest(totalDuration: 2.0)

        player.play(url: url)
        audio.append(engine.render(duration: 2.0))

        testMD5(audio)
    }

    func testStereoConvolution() {
        let url = Bundle.module.url(forResource: "TestResources/drumloop", withExtension: "wav")!

        let engine = AudioEngine()
        let player = AudioPlayer()

        /// Obtained from the 'Listen HRTF Databse' - http://recherche.ircam.fr/equipes/salles/listen/
        let hrirURL = Bundle.module.url(forResource: "TestResources/IRC_1002_R_R0195_T000_P000", withExtension: "wav")!

        let convolution = Convolution(player,
                                      impulseResponseFileURL: hrirURL,
                                      partitionLength: 8192)

        engine.output = convolution

        let audio = engine.startTest(totalDuration: 2.0)

        player.play(url: url)
        audio.append(engine.render(duration: 2.0))

        testMD5(audio)
        audio.audition()
    }
}
