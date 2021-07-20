Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368053D03DA
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhGTUrJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 16:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231751AbhGTUqu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 16:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626816447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13FGH9IcdsNGls40eCSMkR2G2llimRJCFlJpfj0drAA=;
        b=cYI0SzoTnadZnN7Wi/RlkmO1ITesuLeRcbj4sDcr8cLoakq4SFNQIYMV3t1NIaHrMCf5Wy
        4vQ2WEPSEjHySSyp2kmydmVayGTotkBSVDF5TVIXB+7raDVv9/vwCGj8yn0i6aam40oLJ9
        Of3ywYzUSVJl/eE0FGq8ngcwgTa1fok=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-sAO7k9F8NAW8lj4VH4CVuw-1; Tue, 20 Jul 2021 17:27:26 -0400
X-MC-Unique: sAO7k9F8NAW8lj4VH4CVuw-1
Received: by mail-qk1-f199.google.com with SMTP id y3-20020ae9f4030000b02903b916ae903fso135436qkl.6
        for <linux-integrity@vger.kernel.org>; Tue, 20 Jul 2021 14:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=13FGH9IcdsNGls40eCSMkR2G2llimRJCFlJpfj0drAA=;
        b=Mama/HZy60zttfHgQuyiLW0vbg8gWlKekP+7pFaVTvDUXv5utUNEf6ZX7Tk2Ku2qLt
         VCxabHIqW7PiXlqMrpk+D1UyqkAs5YWjVOtpKQ5/+Zf/tOoTXTxTvkXAsPMFU5ekstp2
         a7VWu4t561HPFXGFp1ex7pOkdh5LkYStV4M+Emx3xgS339uo35zdy5DXb4Y5cXEV+9H2
         WGC3j/OsGUnsx2ISx1HgPqDdoBAlUXFnkr96omevmsmXB6z3rMd5fsTRaCOoQ/2y2Yjt
         YLr8kLt+jgmd67LFknTeJ8nGR7YuNPDuX+uUVuOtHUPdhd2GTo9FNeITNoTF6ociWAFr
         2TLg==
X-Gm-Message-State: AOAM532j3Qi0ELaV4C1BsO+LH7+LjrfJg8DEBLCrJhkEOHyEvqYyyrPa
        rR9/ShY42O7ILW/lD35X762uj02aH+NTZcJocrsHuACI7NuFoVO9/0hl3EN3m4NIDgoWG70SCXH
        0zwGu3Wj9EFiTc5++5BUG+xmMvks=
X-Received: by 2002:a37:aa8f:: with SMTP id t137mr30800502qke.277.1626816446231;
        Tue, 20 Jul 2021 14:27:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5ADkrHKUctkZSNxUAO8CeOCIjalPS9tqXHZEs8CzCNQ9nrPOPek18HNDy4oe1aXRTVECpGQ==
X-Received: by 2002:a37:aa8f:: with SMTP id t137mr30800488qke.277.1626816445958;
        Tue, 20 Jul 2021 14:27:25 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u19sm2816359qtx.48.2021.07.20.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 14:27:25 -0700 (PDT)
Date:   Tue, 20 Jul 2021 17:27:24 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     dm-devel@redhat.com, agk@redhat.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com
Subject: Re: [PATCH 0/7] device mapper target measurements using IMA
Message-ID: <YPc/vON2qvwjfvTe@redhat.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 12 2021 at  8:48P -0400,
Tushar Sugandhi <tusharsu@linux.microsoft.com> wrote:

> For a given system, various external services/infrastructure tools
> (including the attestation service) interact with it - both during the
> setup and during rest of the system run-time.  They share sensitive data
> and/or execute critical workload on that system.  The external services
> may want to verify the current run-time state of the relevant kernel
> subsystems before fully trusting the system with business-critical
> data/workload.
> 
> Device mapper is one such kernel subsystem that plays a critical role on
> a given system by providing various important functionalities to the
> block devices with various target types like crypt, verity, integrity 
> etc.  Each of these target types’ functionalities can be configured with
> various attributes.  The attributes chosen to configure these target types
> can significantly impact the security profile of the block device,
> and in-turn, of the system itself.  For instance, the type of encryption
> algorithm and the key size determines the strength of encryption for a
> given block device.
> 
> Therefore, verifying the current state of various block devices as well
> as their various target attributes is crucial for external services
> before fully trusting the system with business-critical data/workload.
> 
> IMA provides the necessary functionality for device mapper to measure the
> state and configuration of various block devices -
>   - BY device mapper itself, from within the kernel,
>   - in a tamper resistant way,
>   - and re-measured - triggered on state/configuration change.
> 
> This patch series uses this IMA functionality, by calling the function
> ima_measure_critical_data(), when a block device state is changed (e.g.
> on device create, resume, rename, remove etc.)  It measures the device
> state and configuration and stores it in IMA logs, so that it can be
> used by external services for managing the system.

I needed to EXPORT_SYMBOL_GPL(ima_measure_critical_data); otherwise I
couldn't compile.. not sure but I can only imagine you compile DM
(and all targets) to be builtin?

In addition to fixing that (in first table load patch) I changed
various things along the way while I reviewed each patch.

Things that I recall are:
- moved #ifdef CONFIG_IMA from dm-ima.c to dm-ima.h
- fixed various typos and whitespace
- consistently prepend "," in STATUSTYPE_IMA's DMEMIT()s as opposed to
  having a mix or pre and postfix throughout targets
- fixed what seemed like malformed STATUSTYPE_IMA handling for
  dm-multipath -- it was DMEMIT(";") for each dm-mpath's pathgroup
- added some fields to dm-mpath, renamed some IMA names in name=value
  pairs to be more clear.

I've staged the result in linux-next via linux-dm.git's dm-5.15
branch, see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.15

I've compiled tested both with and without CONFIG_IMA set.  But
haven't actually tested the code.

Please send any incremental fixes relative to the dm-5.15 branch and
I'll get them folded in where appropriate.

Thanks,
Mike

