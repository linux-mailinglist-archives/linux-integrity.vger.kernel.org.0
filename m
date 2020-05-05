Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443BE1C5D15
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2020 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgEEQMa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 May 2020 12:12:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33694 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgEEQM3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 May 2020 12:12:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id o24so2463642oic.0;
        Tue, 05 May 2020 09:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P4uwIg6IznWYSiI4J+LB8KzTkIyPs2Mm/1Ia9wDW3Qw=;
        b=Uf8Fm/+RQarS5djAk3ZuSuDk6ZIUfYeLVqqmBudontM/TxqpniBnxtKoJA077F4RNI
         /iGW0UXRPytSUB+KHaeR9oep4tqisrQiKi7JGoKmMaNT9W4kyVmb0Hk2wXuEJ/xRlG8Q
         BfGXpc20gzqBqKvcjg+rEk29K/o/Cbi0V6cFzcGO3TkVT2tVv8fDl6YPQIZ6Qmi87ydY
         QvWOoi67TTwjGRiJGh6yTOGqXV/JrOHKpcPMflcvA1Gn8WEU/Vk0M7bx+5hG/N/Ka/BH
         TbL8bdVznQ1E/dIewk/OvpbiF2kIyziU2Xe04EwIRLiVgV2vsLYkFnuJldupPz562DjE
         gACw==
X-Gm-Message-State: AGi0Pua5KQb338WRPQVMrTBRYQmZsmR+Np3ZooBSlFCPxTxNRarsZ4N4
        hmJztXUlC8VBl3UtzA9Kpw==
X-Google-Smtp-Source: APiQypLPTfyCDSQGXksszy6DzFalq0KOuLxkfmgzhJ5Qd4+1aprQV9wF6sc3emzl0a6+rBGzs5/Z+w==
X-Received: by 2002:aca:ed13:: with SMTP id l19mr1736131oih.132.1588695148437;
        Tue, 05 May 2020 09:12:28 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm698707ott.51.2020.05.05.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:12:27 -0700 (PDT)
Received: (nullmailer pid 21692 invoked by uid 1000);
        Tue, 05 May 2020 16:12:26 -0000
Date:   Tue, 5 May 2020 11:12:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        oshri.alkoby@nuvoton.com, tmaimon77@gmail.com, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com
Subject: Re: [PATCH v7 6/7] tpm: Add YAML schema for TPM TIS I2C options
Message-ID: <20200505161226.GA555@bogus>
References: <20200427124931.115697-1-amirmizi6@gmail.com>
 <20200427124931.115697-7-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427124931.115697-7-amirmizi6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 27, 2020 at 03:49:30PM +0300, amirmizi6@gmail.com wrote:
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

Again, DT bindings describe h/w devices, not just a protocol. A device 
is more than just a protocol interface. There's clocks, power rails, 
resets, interrupts, firmware, etc. 

Unless there's something special about TPM chips that makes none of this 
applicable and no chip will ever have any quirks (or extensions) in 
their protocol to work-around, then you need compatible string(s) that 
are specific to the TPM chip. You can have tcg,tpm-tis-i2c as a 
fallback, but you need specific compatible to handle any quirks.

Rob
