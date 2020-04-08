Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A2B1A272D
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2020 18:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbgDHQ2I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Apr 2020 12:28:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40682 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbgDHQ2I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Apr 2020 12:28:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id a81so53239wmf.5;
        Wed, 08 Apr 2020 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HAAR9LDaXSMN6fmU0N4hL9Thu7DJnpi8s/NSBuY2LU8=;
        b=l8VxTngYrsS6jzc9Npxn36OZTP6BXh2Kes2zLxJ9w91W1pa7mfn0F5hsitjMfovyR4
         BVYvqKdXhGzjYnyVtG53ku2nGdzi7IDQtB/JNO+tvCsDGL2R99vuz9v2meg/XdqXrVxN
         RpGSsWkUAy2lagU/vTPE11gRH4NdY5yUMlABi1FbuFzeaHlzOec1jLcouk3x5zwaeO9i
         fV6zVjOY+HLPbQ+pRZdJdmsJI1Gf9I2HTMj/cAtTT5qIrLQc8bVTOlA27VsnrurXeCao
         ODqOZNk7PJKkGFi1ROPvo473Iu2Z2cZXYpT7Wd57x3QBR6lc1rS7DPt1QAsuRU1HRw35
         bNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HAAR9LDaXSMN6fmU0N4hL9Thu7DJnpi8s/NSBuY2LU8=;
        b=T/NccgpfWGOysk7TFEwr/lR1JjIYQFhCSXiky9bb6EROXXfaRFzpBlprGKcaMCNzkE
         11G/nZT7F2nGqPtsnZwDPZU5HXaWkUbTBEizJGYSWrCyu0P6lOgR4aJ2ZPWfJUmFmwer
         S2DMJCufu4c9c6KWsrDjMaf/hd3/rWtukJjxapCQ/vsTM/PiI2Zmh47uf+e7mpA8tNWZ
         rFynejNTIpBiVeecfiRS290WpvAcB4c+exKejwLInrXc8t+wZvTkho3NMd/aCKbxn1Xg
         XLc2QLz5bg2qWbLVLvOmwJ/QN95Sx5Q98tISNfoOflv1ktAj+hCYoTTnLQWK8ifeH7b0
         2g7Q==
X-Gm-Message-State: AGi0PuYJuMUYacbqSW69XRjEQMonzuJWhvrDfodkUlbdvffpiFWG4EMv
        kBFEmAiRHW/B2l3Dyq77iW8=
X-Google-Smtp-Source: APiQypJPZgpqG2YbA8mwXTXx1vX3g4+A3N5go8g7d3L+94vBi4i9aqAgJaRT+zZ8xPsnIdPVGVJuHA==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr5214728wmc.129.1586363285860;
        Wed, 08 Apr 2020 09:28:05 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id o16sm36533957wrs.44.2020.04.08.09.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 09:28:05 -0700 (PDT)
Subject: Re: [RFC] IMA: New IMA measurements for dm-crypt and selinux
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        dm-devel@redhat.com
Cc:     jmorris@namei.org, chpebeni@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@microsoft.com,
        sashal@kernel.org, suredd@microsoft.com
References: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <76a9556d-b141-d26f-7b3c-3887d3a4ae16@gmail.com>
Date:   Wed, 8 Apr 2020 18:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 08/04/2020 12:19, Tushar Sugandhi wrote:
> The goals of the kernel integrity subsystem are to detect if files have
> been accidentally or maliciously altered, both remotely and locally,
> appraise a file's measurement against a "good" value stored as an
> extended attribute, and enforce local file integrity [1].
> 
> To achieve these goals, IMA subsystem measures several in-memory
> constructs and files.
> 
> We propose to measure constructs in dm-crypt and selinux to further
> enhance measuring capabilities of IMA.

...

> Proposal:
> ---------
> A. Measuring dmcrypt constructs:
>      We can add an IMA hook in crypt_ctr() present in
>      drivers/md/dm-crypt.c, so that IMA can start measuring the status of
>      various dm-crypt targets (represented by crypt_target struct - also
>      defined in dm-crypt.c).

Hi,

I do not think you should just cherry-pick dm-crypt here. What about other
device-mapper targets? Apparently, dm-verity or dm-integrity are obvious
candidates too.

But device-mapper logic is based on stacking devices, so in generic case
(not just in some very special embedded configuration) you need to measure
the whole stack of devices.
(Just imagine a target stacked below dm-crypt that decrypts the device or so. :-)

Moreover, dm-crypt allows some specific actions like wiping and reloading
of the encryption key through device-mapper dm-crypt message.
If you check parameter only in crypt_ctr, this message path must be disabled,
basically crippling dm-crypt functionality (it is intended to wipe key in-memory
during hw suspend).


IMO if you want implement something like IMA measurement, I think you should
implement it in device-mapper core, and provide support for all targets.

I guess some new target specific callback is needed and some flags that
could enforce/disable stacking if a IMA measurement is in place etc.

Milan
