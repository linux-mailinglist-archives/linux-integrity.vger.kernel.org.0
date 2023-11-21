Return-Path: <linux-integrity+bounces-151-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B857F3388
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 17:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D53B20F2F
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F0259155;
	Tue, 21 Nov 2023 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E70CB;
	Tue, 21 Nov 2023 08:21:01 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-359d559766cso20729055ab.1;
        Tue, 21 Nov 2023 08:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583661; x=1701188461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB25iOKb1NuNSINJ9ZLnwambMkrdew+0Vk7Thm3qC3I=;
        b=BNCv/ou6MROn27hiDlLfEV0IK/DxsXbM/wIxCGhgyCjsk0DIayf4hpJ0h1r0fjxJPk
         Dmu0Lxl+h8K8vfAC+qvqrGJOEg435opwgmpBGqsJ0sZFqATWDzbKrxpNiFkOWQv6yYmH
         ti57V0TyOwwiIIk473I/uXuE/Lf/CE+ImX8JkokigbazHdToHvOmgOHI8PC/IE5uGX1+
         A05u0RdxbFNigdwOSkU2uwBniZKwEwniYEBFzQrBwpOsArgovIRlCyw3WFmbe3QLIy44
         zoYCxFGMqvLcDQqQ0IX8MqmicjUFYSSrjtuWL41tbUZpHddCwYms+lVuOzI1NVnVU46+
         tdgg==
X-Gm-Message-State: AOJu0YwuTPynq/wRFn31vDl2J5YKEmjjaYnMKoF4/TXTN3QcTosLRya0
	wGl0jHaIC9EDAgDPqCcQjg==
X-Google-Smtp-Source: AGHT+IHe3e6NMuL+N9QoPHujHjV51pxEWuFse8JjWEWJ9MLuc6C6kduDqvpv1Iy/feCZFdtvNvcHww==
X-Received: by 2002:a05:6e02:922:b0:359:47b9:7bef with SMTP id o2-20020a056e02092200b0035947b97befmr11340168ilt.1.1700583660991;
        Tue, 21 Nov 2023 08:21:00 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id bs18-20020a056638451200b0043167542398sm1373780jab.141.2023.11.21.08.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:21:00 -0800 (PST)
Received: (nullmailer pid 2001832 invoked by uid 1000);
	Tue, 21 Nov 2023 16:20:59 -0000
Date: Tue, 21 Nov 2023 09:20:59 -0700
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH 3/3] dt-bindings: tpm: Document Microsoft fTPM bindings
Message-ID: <20231121162059.GE1845293-robh@kernel.org>
References: <cover.1700555862.git.lukas@wunner.de>
 <ad4b484da8190c83902b2525823ceb3439a7576e.1700555862.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4b484da8190c83902b2525823ceb3439a7576e.1700555862.git.lukas@wunner.de>

On Tue, Nov 21, 2023 at 10:48:43AM +0100, Lukas Wunner wrote:
> A driver for Microsoft's firmware-based Trusted Platform Module (fTPM)
> was merged with commit 09e574831b27 ("tpm/tpm_ftpm_tee: A driver for
> firmware TPM running inside TEE"), but its devicetree bindings were not.
> 
> This is the only remaining undocumented compatible string for a TPM,
> so add a DT schema based on the patch linked below.
> 
> Link: https://lore.kernel.org/all/20190409184958.7476-2-sashal@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  .../bindings/tpm/microsoft,ftpm.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

