Return-Path: <linux-integrity+bounces-147-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBEF7F3274
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 16:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DE01C210F3
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88D9482EE;
	Tue, 21 Nov 2023 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8812E91;
	Tue, 21 Nov 2023 07:38:00 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-359d559766cso20528835ab.1;
        Tue, 21 Nov 2023 07:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700581080; x=1701185880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph1AsBAWP7qFGjH8rDb0y5F4XcrTT5x+OvVHmKjlJLI=;
        b=kEDB30FoXuDzYSCjGCAtgjswNTTQv67QSNhHSF2j7DvcN24bwKjEy9say4DWalN+OR
         LiLPB3DDNBl4uzJU303XoE+EJQg+stRu4dJi+dk+P/qW/ie8KoMTuEThsoE1S9ipzQS9
         DtTMh2rpp/aPVMHinGZWCm3Aahg21wyjqNII89x2xYGirx3m45B7raJQAQzd2VWo/6tc
         iuzGuyCmIMUhQCyYXy11aMR/Dq8njcrjlVTb9oQXerxZQuTwEQouOI/IRXJ9glPLO8e8
         lbKUlLGkSUqEALPpNagilCX5iy9vUUpKRyUK8Qp4kTMAPYsZPAKWsSYjYDmo8yjLeMLj
         nSAA==
X-Gm-Message-State: AOJu0Yyz2QhdVd1ogx3iNdKGXh7YiswVGcHh+9tfT6IHqKEGZA6ff3Dm
	JGGaDy51zWoZ1DsfR19RYxUdGAFiXA==
X-Google-Smtp-Source: AGHT+IEbT+q08QUJLr+BBJ/82b2gbFkjZ922AgKckSVEfExi6tjjWZm0hLQiZC0wTQiYQDdTPKE8Aw==
X-Received: by 2002:a05:6e02:1b83:b0:35a:fbe8:aafc with SMTP id h3-20020a056e021b8300b0035afbe8aafcmr12572841ili.8.1700581079823;
        Tue, 21 Nov 2023 07:37:59 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k13-20020a056e021a8d00b0035b2eaa8b04sm128550ilv.60.2023.11.21.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:37:59 -0800 (PST)
Received: (nullmailer pid 1850826 invoked by uid 1000);
	Tue, 21 Nov 2023 15:37:57 -0000
Date: Tue, 21 Nov 2023 08:37:57 -0700
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-integrity@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: tpm: Consolidate TCG TIS bindings
Message-ID: <20231121153757.GA1845293-robh@kernel.org>
References: <cover.1700555862.git.lukas@wunner.de>
 <e83a43a67c96b4f2614f029666209cb408da8678.1700555862.git.lukas@wunner.de>
 <170056423883.1245414.13982600686594579960.robh@kernel.org>
 <20231121110210.GA22827@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121110210.GA22827@wunner.de>

On Tue, Nov 21, 2023 at 12:02:10PM +0100, Lukas Wunner wrote:
> On Tue, Nov 21, 2023 at 03:57:21AM -0700, Rob Herring wrote:
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> Your bot hasn't read the cover letter, which discusses those errors:
> 
> https://lore.kernel.org/linux-devicetree/cover.1700555862.git.lukas@wunner.de/

Yeah, the bot doesn't read. It used to, but then replies would only 
happen if its master was working. It's all Krzysztof's fault for 
reviewing faster than the bot. 

This should all be fixed in dtschema main branch now.

Rob

