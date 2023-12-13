Return-Path: <linux-integrity+bounces-429-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F68118DC
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F2E1F21540
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3415B33065;
	Wed, 13 Dec 2023 16:13:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5810C;
	Wed, 13 Dec 2023 08:13:50 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6d84ddd642fso5401517a34.0;
        Wed, 13 Dec 2023 08:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484030; x=1703088830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKFwCtE90EPD9y2XJTF44lWNSwXrZ/Ik0w5o/94t9wo=;
        b=rLZ6s6hq/+A38IhIqZVpVkgN+VX8AoxjGU3N+/LbhM25VpWREgQRJtSHby3lCgobnx
         nX/9Lj1F0oYr88SSYoDDRPsBp616pYKM/KV+lh6Qc1NKyTpXosVV3mMJhIMbUTObiGIb
         qXN3TQt4yqMdltmAs6WfvORcYJgM1i1doHR9cnHs1VzAJ+bVb8ClN1U/CevilJ+LLZod
         wa47GVOU5+NddKS8Obp5UFTsUtrmVbyBWr/iyxyXd4dK8AaqRcc2xCXPrCz9tK2coygw
         NLuWi3zkS4UPXjpGp1mBKaGMh+eJ0Jwpg2Yn9aEM9IdP3vM7sIW7no9oJkBKBnVp6WyD
         fvqw==
X-Gm-Message-State: AOJu0Yx/oYmJxqOTsLOMMRqP96FcxL8ovJlR6rWNiAg2LOVb65qdc/0B
	x9xP/8njEvAX9s+MrifTLw==
X-Google-Smtp-Source: AGHT+IHvwtas0Wz/5QoHKT/kRL+DgeC/VW8MvnUtSILOIvJ0GIakLipYqdQA3Ql3Vum+yJU0aDi0bQ==
X-Received: by 2002:a05:6871:6b90:b0:1fa:ff63:2d3b with SMTP id zh16-20020a0568716b9000b001faff632d3bmr7032507oab.44.1702484029822;
        Wed, 13 Dec 2023 08:13:49 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zl10-20020a0568716d8a00b001fb42001fa7sm3978002oab.36.2023.12.13.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:13:49 -0800 (PST)
Received: (nullmailer pid 1207750 invoked by uid 1000);
	Wed, 13 Dec 2023 16:13:47 -0000
Date: Wed, 13 Dec 2023 10:13:47 -0600
From: Rob Herring <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, johannes.holland@infineon.com, linux@roeck-us.net, broonie@kernel.org, patrick.rudolph@9elements.com, vincent@vtremblay.dev, peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, bhelgaas@google.com, naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com, festevam@denx.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org, geissonator@yahoo.com
Subject: Re: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
Message-ID: <20231213161347.GA1204384-robh@kernel.org>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212164004.1683589-3-ninad@linux.ibm.com>

On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
> From: Johannes Holland <johannes.holland@infineon.com>
> 
> Add a dt schema to support device tree bindings for the generic I2C
> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> Specification for TPM 2.0 v1.04 Revision 14.
> 
> This includes descriptions for the Nuvoton and Infineon devices.

This is incomplete and conflicts with this series[1]. Please help 
review and make sure it works for the cases you care about.

Rob

[1] https://lore.kernel.org/all/cover.1701093036.git.lukas@wunner.de/

