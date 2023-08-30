Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD0D78DCE6
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 20:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbjH3SrB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 14:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344200AbjH3S0y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 14:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A247919A
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693419963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=536hEdeJYk89mYwQhbVybpmlRd6HjhERfF4XbjkRN4c=;
        b=ghJvXEoo++yQfJOuziGrRadZeHEeqELLzHtLJVo/yB5RY5kWm232kL1jk2quvM4nGwzUyF
        vHftsXcvjHbV7g+DT+UilIbaOdaw6GRme3Y/UTBu35A42j0N31jn9xso/GfcpvSiG2VTxs
        6EEtb/p5NP/71REeG7t4sBTq8FANrz0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-utHRCWoPMLuYvU_OEx_H8g-1; Wed, 30 Aug 2023 14:26:00 -0400
X-MC-Unique: utHRCWoPMLuYvU_OEx_H8g-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2717f4ba116so52223a91.0
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 11:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693419959; x=1694024759;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=536hEdeJYk89mYwQhbVybpmlRd6HjhERfF4XbjkRN4c=;
        b=fHEXZ1oLLKIyIuXNq2cCE1h1oEXdHg2pAR6X7qAOGzmlSxBM49qhnknuIFw4T4lEKE
         /zvopy3MTx5cSGblISxzk2g5FD+Zb0Da971e5id9Y48lVeYriro3061huZ/EVRtM/LDK
         URnzOwEEnuoku3kwhbZOhFkp6ZRcDqQzVZv26Hv478vRNb+iapmlkkXO+lTWUrbmAysB
         aMtg4xVsXMncuFgq/ZXT2Layzf81rEWLA1aIhxcLEAiF8zkjbaVCU7QYb0fmMZqwq5LS
         XHM8ftitwhrY6wDpz6D+4HuMy1NtWnuDEgyc239gfqmhIE706YX+GXUEBSUczQvbHaz5
         pqSg==
X-Gm-Message-State: AOJu0YxjPKVKFw7paW29bMpzyySzWoH3DQe/BS7fLwPeakk9HpmhI0YN
        rjBpR1FNEMVMeYgFdDYcRUOL5vCvs3vabRaLupYl5tlTZVxsK8gg8BzRnsP4J4Y04Q97qLvU9Up
        YM1Xz28FRLm6Zn+uLCUOgQQ23TVQz
X-Received: by 2002:a17:902:ea0f:b0:1b8:a88c:4dc6 with SMTP id s15-20020a170902ea0f00b001b8a88c4dc6mr3373225plg.45.1693419958891;
        Wed, 30 Aug 2023 11:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJpuzkMKCcUxXuBwzDEAWKKYDzm/197FeA+Z+f1IJBUSeHVr2tKRuQSsaHopYrWCL9mnbIjA==
X-Received: by 2002:a17:902:ea0f:b0:1b8:a88c:4dc6 with SMTP id s15-20020a170902ea0f00b001b8a88c4dc6mr3373207plg.45.1693419958613;
        Wed, 30 Aug 2023 11:25:58 -0700 (PDT)
Received: from smtpclient.apple ([2600:1011:b15c:d1ac:a90e:1171:fe6:7d04])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001bbaf09ce15sm11357005plb.152.2023.08.30.11.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 11:25:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
Date:   Wed, 30 Aug 2023 11:25:45 -0700
Message-Id: <446E94FC-C47A-453F-9A0E-CBE5049582ED@redhat.com>
References: <zlywbvfgkkygcpvmj5rd4thuhbdacit2meg2fj6eyua5qpwyoc@beyiattrr7o6>
Cc:     linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <zlywbvfgkkygcpvmj5rd4thuhbdacit2meg2fj6eyua5qpwyoc@beyiattrr7o6>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: iPhone Mail (20G75)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Aug 29, 2023, at 12:03 PM, Jerry Snitselaar <jsnitsel@redhat.com> wrote=
:
>=20
> =EF=BB=BFOn Wed, Aug 23, 2023 at 02:15:10AM +0300, Jarkko Sakkinen wrote:
>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for=

>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the=

>> reported systems the TPM doesn't reply at bootup and returns back the
>> command code. This makes the TPM fail probe.
>>=20
>> Since only Microsoft Pluton is the only known combination of AMD CPU and
>> fTPM from other vendor, disable hwrng otherwise. In order to make sysadmi=
n
>> aware of this, print also info message to the klog.
>>=20
>> Cc: stable@vger.kernel.org
>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>> v3:
>> * Forgot to amend config flags.
>> v2:
>> * CONFIG_X86
>> * Removed "Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>"
>> * Removed "Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>"
>> ---
>> drivers/char/tpm/tpm_crb.c | 33 ++++++++-------------------------
>> 1 file changed, 8 insertions(+), 25 deletions(-)
>>=20
>=20
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


It looks like the Fedora folks are getting more reports of the issue.=

