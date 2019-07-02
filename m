Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E965D18E
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2019 16:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGBOVP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Jul 2019 10:21:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34898 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfGBOVO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jul 2019 10:21:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id c27so10362588wrb.2
        for <linux-integrity@vger.kernel.org>; Tue, 02 Jul 2019 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0T0bkaVX+wFo4N32YlZXYNiR/7O5n98pISnD8ARqYHs=;
        b=mhch/ZQnDFaRuGeaeQn210tNIkyw81M4xjEEW5OVV26kZDvcSBUufpYKMrDOEZxHJO
         GqQcS9gGECO8hlAQeW97kI2Kce+6NXwlhJhFzsENIc/OLCkDS8MzgjQN5iMTkLHsbHPk
         anWBdlZ/KHPWZbiU9klzy8BSsVT6Kqb/SrEsLOpv9h9pCM3fz2/OozBPMda1EUvx6eCY
         J5C+bnh1K4JBvEm7z+G0gXRoKjakDfOaguWklBmsMHM/hUWgaaeJNAPdSKf/IuTx4yj1
         nh/60lT3fPpBhFByk8ZkRp54DlbCil76U3T3qqQPONViDjMfRCHNY8gJCpm5nLNwN3Tc
         nPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0T0bkaVX+wFo4N32YlZXYNiR/7O5n98pISnD8ARqYHs=;
        b=AVtRVb62WN728dYHkODrGmUU0Qyy6tVFNOu5g4W+Bubr2eZSWih/gCUj6osQGMk1UO
         7yJx3sv3y2GqbFrry4UQsrUH/qVY8R4SZWnrcskhyhxxR4dS8t5tQ+7q19mJ+HXgbH1H
         s4tE7nY6vhCZXg2apLRLdb9JBdpHTbaym1NEDQ9kzq3pZFZPDPZHrSzPbuTtH7XIiBId
         LcWX/SZ24W/z6Y4h+6XmVcjLm9JGitjeK7Va4qwut2k1RE2IvUgd+FS4Sx7rUp5xteGG
         t0nSDdMRmPIoKU5+QALsMy/R26q1R/iJBEReTrQ5QZUatR0Zswib5lr5AE0qZtR8nsUJ
         StOA==
X-Gm-Message-State: APjAAAUrpKEY9KRfHmy3fGarNh4s1bR7Le66BtN0Nv66tjhRHeR6rary
        2D2VLRYC1ryMieLDcyHZl1Mt3A==
X-Google-Smtp-Source: APXvYqyCI2efyMIR3muhRyuBtQrsbaQPkg/M8stSquNHreZP+SaS6imoe173p76G1uUfDIl8YwHsFw==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr662423wrw.349.1562077273050;
        Tue, 02 Jul 2019 07:21:13 -0700 (PDT)
Received: from apalos (athedsl-428434.home.otenet.gr. [79.131.225.144])
        by smtp.gmail.com with ESMTPSA id r6sm3176635wmh.11.2019.07.02.07.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 07:21:12 -0700 (PDT)
Date:   Tue, 2 Jul 2019 17:21:09 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190702142109.GA32069@apalos>
References: <20190625201341.15865-1-sashal@kernel.org>
 <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm>
 <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
 <20190627133004.GA3757@apalos>
 <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> On Thu, 2019-06-27 at 16:30 +0300, Ilias Apalodimas wrote:
> > is really useful. I don't have hardware to test this at the moment, but once i
> > get it, i'll give it a spin.
> 
> Thank you for responding, really appreciate it.
> 
No worries
> Please note, however, that I already did my v5.3 PR so there is a lot of
> time to give it a spin. In all cases, we will find a way to put this to
> my v5.4 PR. I don't see any reason why not.
> 
> As soon as the cosmetic stuff is fixed that I remarked in v7 I'm ready
> to take this to my tree and after that soonish make it available on
> linux-next.
I managed to do some quick testing in QEMU. 
Everything works fine when i build this as a module (using IBM's TPM 2.0 TSS)

- As module
# insmod /lib/modules/5.2.0-rc1/kernel/drivers/char/tpm/tpm_ftpm_tee.ko
# getrandom -by 8
randomBytes length 8
23 b9 3d c3 90 13 d9 6b 

- Built-in
# dmesg | grep optee
ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session failed,
err=ffff0008
ftpm-tee: probe of firmware:optee failed with error -22
# getrandom -by 8
random: fast init done
urandom_read: 2 callbacks suppressed
random: getrandom: uninitialized urandom read (32 bytes read)
TSS_Dev_Open: Error opening /dev/tpm0
getrandom: failed, rc 000b0008
TSS_RC_NO_CONNECTION - Failure connecting to lower layer

Am i missing anything?

Thanks
/Ilias
