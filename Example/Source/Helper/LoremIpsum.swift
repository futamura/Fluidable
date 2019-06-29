//
//  LoremIpsum.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

class LoremIpsum {

    private static let lines: [String] = ["Praesent gravida neque at auctor blandit.",
                                  "Nunc vel lacus quis arcu scelerisque auctor placerat a mauris.",
                                  "Curabitur elementum ante sit amet mauris faucibus placerat.",
                                  "Curabitur et nisl eu lorem commodo pretium scelerisque sed ipsum.",
                                  "Praesent tempus felis a arcu tempus, vitae vehicula nulla ultrices.",
                                  "Nullam semper metus nec mi consectetur finibus.",
                                  "Integer ultricies orci sit amet nulla tempus lobortis.",
                                  "Sed sit amet sapien tincidunt, feugiat felis et, faucibus sapien.",
                                  "In a enim tempus, feugiat ipsum ac, dignissim nibh.",
                                  "Quisque interdum massa id eros porta fringilla.",
                                  "Quisque dignissim felis ut ullamcorper mollis.",
                                  "Praesent consequat turpis ut quam consequat, et mollis ligula dapibus.",
                                  "Duis vel nibh vitae leo tincidunt mattis.",
                                  "Curabitur sagittis urna sed convallis finibus.",
                                  "Vivamus vitae nibh a ligula convallis lacinia.",
                                  "Suspendisse aliquam odio elementum mauris consequat sodales.",
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                  "Morbi ac dolor cursus, gravida dolor tincidunt, pharetra lacus.",
                                  "Etiam dapibus quam at mauris viverra condimentum.",
                                  "Aliquam fringilla velit consequat cursus efficitur.",
                                  "Cras ut quam aliquam, imperdiet lorem nec, accumsan nisl.",
                                  "Nullam eget eros eu lectus dignissim dignissim ut semper risus.",
                                  "Mauris dignissim leo aliquam quam feugiat blandit.",
                                  "Donec porttitor orci quis velit pulvinar fringilla.",
                                  "In vel enim vel purus tristique molestie.",
                                  "Donec blandit lorem a fermentum rutrum.",
                                  "Integer feugiat ex ac nulla consequat, at mattis quam euismod.",
                                  "Etiam a lorem eleifend, porta est vel, condimentum ex.",
                                  "Aliquam maximus tortor ac diam sagittis, in lacinia dui euismod.",
                                  "Curabitur varius nisl id luctus tempus.",
                                  "Maecenas pellentesque dolor ac posuere auctor.",
                                  "Sed mattis ex eget dui lacinia imperdiet.",
                                  "Ut ut leo eu sapien eleifend egestas sit amet eu tellus.",
                                  "Curabitur bibendum sem quis urna convallis, eget dictum tellus pellentesque.",
                                  "Maecenas et quam eu arcu rutrum porta.",
                                  "Vestibulum finibus augue sit amet nunc fermentum, at molestie dolor pretium.",
                                  "Fusce rhoncus lorem dignissim sem congue, et facilisis risus tincidunt.",
                                  "Nunc volutpat turpis sed lorem luctus placerat.",
                                  "Ut eget urna vehicula, pulvinar nulla quis, feugiat metus."]

    private let paragraphs: [String] = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce pharetra, nisl ac gravida accumsan, tortor elit sodales purus, nec placerat quam sapien eu dui. Phasellus congue leo non dolor pretium, in varius metus suscipit. Ut aliquam ex et congue semper. Curabitur interdum ante id felis sagittis gravida. Nullam sit amet imperdiet metus. Donec scelerisque sollicitudin massa eget tempor. Curabitur et diam finibus, hendrerit justo vitae, dapibus ipsum. Duis varius diam nec est feugiat dictum.",
                                        "Vivamus non fermentum nisl. Aenean tempor, erat quis pellentesque scelerisque, dui ligula varius enim, vitae pellentesque eros velit eget tellus. Duis a fermentum nisi, eget cursus nunc. Sed hendrerit turpis sed ligula posuere dapibus facilisis eget magna. Maecenas consectetur, tortor quis finibus auctor, nisl leo malesuada libero, et commodo sem enim elementum lectus. Nunc ac tincidunt nisi. Etiam quis scelerisque sem, ut efficitur tellus. Morbi diam arcu, egestas a venenatis a, pulvinar interdum metus. Nam sit amet efficitur diam. Suspendisse nec fermentum nulla. Cras aliquam ullamcorper nunc nec bibendum. Integer blandit efficitur sapien ut pulvinar. Fusce felis massa, pretium sit amet consequat ac, consequat dictum metus. Vestibulum vel arcu sed erat feugiat hendrerit. Praesent faucibus elit id libero viverra, non consectetur dolor dictum. Ut augue nulla, rutrum vel ex et, finibus tempor diam.",
                                        "Aenean non nunc turpis. Nulla justo sapien, lacinia vitae pharetra a, venenatis et purus. Donec vel neque erat. Integer ac dolor quis ante tempus fringilla. Morbi mollis lectus sit amet elit consectetur, eu elementum dolor mollis. Proin sed interdum libero. In pellentesque hendrerit velit, sit amet consequat mi tempor condimentum. Vestibulum eu gravida nulla. Nam vitae hendrerit risus.",
                                        "In vitae libero laoreet, cursus ex ac, efficitur lorem. Nullam tincidunt mollis nibh vehicula tristique. Cras consequat ante ac sagittis tincidunt. Cras ullamcorper sem ac leo euismod finibus. Suspendisse at fermentum mi, sit amet faucibus justo. Curabitur ac porttitor lorem, sit amet molestie quam. Etiam enim sapien, iaculis et venenatis ut, malesuada quis enim. Pellentesque sit amet orci in purus cursus imperdiet. Suspendisse ex orci, cursus quis nisl volutpat, aliquet tempus massa.",
                                        "Nulla facilisi. Ut id luctus dui, vitae vehicula mi. Aenean rhoncus nisl ac justo tincidunt luctus. Nullam vitae massa mauris. Donec suscipit leo sed tortor malesuada tristique. Phasellus quis lorem vitae lectus blandit aliquam vel malesuada mi. Nullam metus ipsum, laoreet ac condimentum eu, malesuada sit amet mauris. Integer at vehicula libero, sit amet malesuada libero. Duis id leo quis magna tincidunt imperdiet eget ut magna. Integer sagittis, augue quis rhoncus lobortis, mi mauris malesuada diam, in pharetra orci libero ut libero. Nullam vitae scelerisque ante. Ut ac risus porta augue blandit interdum. Nullam at fermentum orci. Sed a augue id nisl porttitor semper et quis metus. Cras ac consectetur lectus, quis pulvinar orci."]

    static func line(at index: Int) -> String {
        let odd = Int(CGFloat(index).truncatingRemainder(dividingBy: CGFloat(lines.count)))
        return lines[odd]
    }
}
