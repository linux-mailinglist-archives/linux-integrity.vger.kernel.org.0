Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3F1E2A11
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2020 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgEZSbN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 14:31:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44501 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgEZSbN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 14:31:13 -0400
Received: by mail-io1-f65.google.com with SMTP id p20so9734386iop.11;
        Tue, 26 May 2020 11:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Lz4//1z2ZrWHaf5fTT44ISM/EApcBJeJCpGJbLcQ7I=;
        b=TiIZmxPWL9LSIDPNdDxEzwgPnobu9+Y2/cdgf/T+q4IW742XE+2RNAWJxQRm1cfCBl
         h0QkpXixjhuJDIeOrsyytcKA/DkdmWPqMUzFm4mK1IdU6m9YDgUYdTO/Kyyh6EXmh25W
         rSLmGqqGLCH+LTSBIqbZt/+fg7PLEvA4yKqXwa/F3wYqgn3SNmxcI3tW9w2yvHBEAOGA
         GRDg8Lpq7+ApygmqQHP9wNOcafAdor1jgkYQ8MVXEii6uPFQWW4z0/US0KSJIBJSaek2
         hHY3wGqcwU0kEbscAUcPY760DEcpS9IoaYqMSaHzNM0iLdmz4yzEHG5P73yz52VhK9gM
         Xvpw==
X-Gm-Message-State: AOAM531oD6m5bd1Od8L1bcLzsW3OKWoGS1iZ+pfflzXu6as7q7HtdkZi
        3OpZp4GwUPyy5OVuSVwFeQ==
X-Google-Smtp-Source: ABdhPJwzrhgUCSrXyhw34o2MneTMGR3pkuaPU9wiVQaHPVclL0neGvls6Q/hiHwIpqM1xK+SeMu/CA==
X-Received: by 2002:a05:6638:1405:: with SMTP id k5mr2199979jad.108.1590517872401;
        Tue, 26 May 2020 11:31:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d10sm362125ils.69.2020.05.26.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:31:11 -0700 (PDT)
Received: (nullmailer pid 133591 invoked by uid 1000);
        Tue, 26 May 2020 18:31:10 -0000
Date:   Tue, 26 May 2020 12:31:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     amirmizi6@gmail.com
Cc:     amir.mizinski@nuvoton.com, robh+dt@kernel.org,
        shmulik.hager@nuvoton.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, tmaimon77@gmail.com,
        christophe-h.richard@st.com, linux-integrity@vger.kernel.org,
        Eyal.Cohen@nuvoton.com, gcwilson@us.ibm.com,
        oshri.alkoby@nuvoton.com, oren.tanami@nuvoton.com,
        oshrialkoby85@gmail.com, jgg@ziepe.ca, peterhuewe@gmx.de,
        kgoldman@us.ibm.com, Dan.Morav@nuvoton.com,
        gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        alexander.steffen@infineon.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 7/8] tpm: Add YAML schema for TPM TIS I2C options
Message-ID: <20200526183110.GA133552@bogus>
References: <20200526141658.157801-1-amirmizi6@gmail.com>
 <20200526141658.157801-8-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526141658.157801-8-amirmizi6@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 26 May 2020 17:16:57 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Added a YAML schema to support tpm tis i2c related dt-bindings for the I2c
> PTP based physical layer.
> 
> This patch adds the documentation for corresponding device tree bindings of
> I2C based Physical TPM.
> Refer to the 'I2C Interface Definition' section in
> 'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
> for specification.
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
