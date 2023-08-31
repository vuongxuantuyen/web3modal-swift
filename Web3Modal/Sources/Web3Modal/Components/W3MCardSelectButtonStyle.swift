import SwiftUI

struct W3MCardSelectStyle: ButtonStyle {
    enum Variant {
        case wallet
        case network
    }

    @Environment(\.isEnabled) var isEnabled

    let variant: Variant
    let imageUrl: URL

    @State var isLoading = false

    init(variant: Variant, imageUrl: URL) {
        self.variant = variant
        self.imageUrl = imageUrl
    }

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: Spacing.xs) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .transform { image in
                        switch variant {
                        case .network:
                            image.clipShape(Hexagon())
                        case .wallet:
                            image.clipShape(RoundedRectangle(cornerRadius: Radius.xs))
                        }
                    }
                    .saturation(isEnabled ? 1 : 0)
                    .opacity(isEnabled ? 1 : 0.5)
                    .onAppear {
                        isLoading = false
                    }
            } placeholder: {
                Image("placeholder")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 56, height: 56)
            .overlay {
                RoundedRectangle(cornerRadius: Radius.xs)
                    .strokeBorder(.Overgray005, lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: Radius.xs).fill(.Overgray010))
                    .opacity(isLoading ? 1 : 0)
            }
            .onAppear {
                isLoading = true
            }

            configuration.label
                .font(.tiny500)
                .foregroundColor(configuration.isPressed ? .Blue100 : .Foreground100)
                .frame(maxWidth: .infinity)
                .overlay {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.Overgray005, lineWidth: 1)
                        .opacity(isLoading ? 1 : 0)
                }
                .opacity(isEnabled ? 1 : 0.5)
                .padding(.horizontal, Spacing.xs)
        }
        .padding(.top, Spacing.xs)
        .padding(.bottom, Spacing.xxs)
        .background(configuration.isPressed ? .Overgray010 : .Overgray002)
        .cornerRadius(Radius.xs)
        .overlay {
            RoundedRectangle(cornerRadius: Radius.xs)
                .stroke(.Overgray005, lineWidth: 1)
        }
        .frame(minWidth: 76, maxWidth: 76, minHeight: 96, maxHeight: 96)
    }
}

struct W3MCardSelect_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                Button(action: {}, label: {
                    Text("Rainbow")
                })
                .buttonStyle(W3MCardSelectStyle(
                    variant: .wallet,
                    imageUrl: URL(string: "https://explorer-api.walletconnect.com/w3m/v1/getWalletImage/7a33d7f1-3d12-4b5c-f3ee-5cd83cb1b500?projectId=c1781fc385454899a2b1385a2b83df3b")!
                ))
                
                Button(action: {}, label: {
                    Text("Rainbow")
                })
                .buttonStyle(W3MCardSelectStyle(
                    variant: .wallet,
                    imageUrl: URL(string: "https://explorer-api.walletconnect.com/w3m/v1/getWalletImage/7a33d7f1-3d12-4b5c-f3ee-5cd83cb1b500?projectId=c1781fc385454899a2b1385a2b83df3b")!
                ))
                .disabled(true)
            }
            
            HStack {
                Button(action: {}, label: {
                    Text("Rainbow")
                })
                .buttonStyle(W3MCardSelectStyle(
                    variant: .network,
                    imageUrl: URL(string: "https://explorer-api.walletconnect.com/w3m/v1/getWalletImage/7a33d7f1-3d12-4b5c-f3ee-5cd83cb1b500?projectId=c1781fc385454899a2b1385a2b83df3b")!
                ))
                Button(action: {}, label: {
                    Text("Rainbow")
                })
                .buttonStyle(W3MCardSelectStyle(
                    variant: .network,
                    imageUrl: URL(string: "https://explorer-api.walletconnect.com/w3m/v1/getWalletImage/7a33d7f1-3d12-4b5c-f3ee-5cd83cb1b500?projectId=c1781fc385454899a2b1385a2b83df3b")!
                ))
                .disabled(true)
            }
        }
    }
}

struct Hexagon: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let sideLength = min(rect.width, rect.height)
        let centerX = rect.midX
        let centerY = rect.midY
        
        path.move(to: CGPoint(x: centerX + sideLength / 2, y: centerY))

        for i in 1 ... 6 {
            let angle = CGFloat(i) * CGFloat.pi / 3
            let x = centerX + sideLength/2 * CGFloat(cos(angle))
            let y = centerY + sideLength/2 * CGFloat(sin(angle))
            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.closeSubpath()

        return path
    }
}
