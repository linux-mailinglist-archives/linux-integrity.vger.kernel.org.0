Return-Path: <linux-integrity+bounces-212-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394F7F6EB3
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Nov 2023 09:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8715B20C42
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Nov 2023 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE42319D;
	Fri, 24 Nov 2023 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EB8D7E;
	Fri, 24 Nov 2023 00:43:33 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id AA769300002AE;
	Fri, 24 Nov 2023 09:43:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9CD151002F; Fri, 24 Nov 2023 09:43:31 +0100 (CET)
Date: Fri, 24 Nov 2023 09:43:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH 2/3] dt-bindings: tpm: Convert IBM vTPM bindings to DT
 schema
Message-ID: <20231124084331.GA18424@wunner.de>
References: <cover.1700555862.git.lukas@wunner.de>
 <fc5c973d30df7ece297e19edad19ffe86378b6b1.1700555862.git.lukas@wunner.de>
 <20231121161925.GD1845293-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121161925.GD1845293-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 21, 2023 at 09:19:25AM -0700, Rob Herring wrote:
> On Tue, Nov 21, 2023 at 10:48:42AM +0100, Lukas Wunner wrote:
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - IBM,vtpm
> > +      - IBM,vtpm20
> > +
> > +  device_type:
> > +    description:
> > +      type of virtual device
> 
> const: IBM,vtpm

Hm, since IBM,vtpm20 is a valid compatible string, I'm guessing it's a
valid device_type as well, so instead of a const I intend to use:

  device_type:
    description:
      type of virtual device
    enum:
      - IBM,vtpm
      - IBM,vtpm20

Thanks,

Lukas

