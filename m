Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0001D28BA
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgENH1u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 03:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgENH1u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 03:27:50 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06976C061A0E
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 00:27:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r17so1710987lff.9
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvIg8OTmvpD4AIra61gchuv+YQzJPkLcRjdOE9A6l2A=;
        b=T58w69kBOxFktle1yYsy3hLN3gMn/osjm5YR8FTXl4uYp8PjKu2TZzOiHNgCx36vrE
         Wl/ZIQZLvdR8y6+piwx3KEwGBHD8kyjMwzas/eYyJaxuJxY8/KGnPz4HlvtDAulI9I15
         lGRt7VR2EK+bxqp2oZhR93/egU4OCxQtySGt6pV8RF67V5Vj3IcxPdw3Km1KhdoaRiaq
         bSo22sNuywieNiZ1fpmYK7epfyyHEaUnQ1U7yB7K1aXP/AJXWde5jIFrUkDbeeALECIL
         u0FuTV6q/ZfQm1Z7KARSGRX7zu3oek6QkvyBvFcfjjmEMIagj6XaGUbGVW2NX71/UJ7h
         Omtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvIg8OTmvpD4AIra61gchuv+YQzJPkLcRjdOE9A6l2A=;
        b=i5MU5DxgwlDmQSJeR7865f6GqMOoKVruc6Gc/seuk4cDqrIPxJmzHeeXpLWgUfYk8+
         VxQuHDxOCbzfl9s6uRf14Qrzjg737kP1QV+mwnY9o/YNb3Yh2yH0iolHl4s3TEYsX+/d
         /VeUCgBmdtFFw87ysNGBsZZKvFCWn82V0i+XKfhxaDwtYWBKteeczrkUctOkv3wucaNQ
         qMXYGeU9a1BAhpUeokZWNron7RGRUNA5cOZdhLc4CswO9H/Uaq8trGEKaHl/PJCfzl1V
         fTehDmxJfFQq+VhUk7vdkv2OwfxU6vgpY3VtswE40Px30uXVPwZwScvUXjjLvI2socg9
         883g==
X-Gm-Message-State: AOAM532x31OBaGWbrL2gF7YMWU1ELDuDhliJmNq4N3yzdFOyXtE40BEq
        t5KAFpIWWZplHjDnMdqyf2rxgsA59xatBDyfjvU77Q==
X-Google-Smtp-Source: ABdhPJzL0WsvMihqen9758VYmk6yEgm/ZN9/XilvuCWzmgJOy/SB9sZscduKIMjRAKM98dv/ishZnbn+Lr4DfqPaa0A=
X-Received: by 2002:a19:ccce:: with SMTP id c197mr2356496lfg.59.1589441267234;
 Thu, 14 May 2020 00:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
 <1588758017-30426-3-git-send-email-sumit.garg@linaro.org> <ef2093f96eae7e9e6785f2c0ad00604d8adfd3be.camel@linux.intel.com>
In-Reply-To: <ef2093f96eae7e9e6785f2c0ad00604d8adfd3be.camel@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 14 May 2020 12:57:35 +0530
Message-ID: <CAFA6WYPr1iL-uJgSRu_61uv=2DhuEdDVdQLDuyPEOOK2jEgvyg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>, dhowells@redhat.com,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: multipart/mixed; boundary="00000000000021218505a596a2dc"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--00000000000021218505a596a2dc
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 May 2020 at 05:58, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key.
> >
> > Refer to Documentation/tee.txt for detailed information about TEE.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> The implementation looks solid but how or who could possibly test this?
>
> I do posses (personally, not from employer) bunch of ARM boards but my
> TZ knowledge is somewhat limited (e.g. how can I get something running
> in TZ).
>

Although, it should be fairly easy to test this implementation on an
ARM board which supports OP-TEE. But since you are new to ARM
TrustZone world, I would suggest you get used to OP-TEE on Qemu based
setup. You could find pretty good documentation for this here [1] but
for simplicity let me document steps here to test this trusted keys
feature from scratch:

# Install prerequisites as mentioned here [2]

# Get the source code
$ mkdir -p <optee-project>
$ cd <optee-project>
$ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
$ repo sync -j4 --no-clone-bundle

# Get the toolchain
$ cd <optee-project>/build
$ make -j2 toolchains

# As trusted keys work is based on latest tpmdd/master, so we can
change Linux base as follows:
$ cd <optee-project>/linux
$ git remote add tpmdd git://git.infradead.org/users/jjs/linux-tpmdd.git
$ git pull tpmdd
$ git checkout -b tpmdd-master remotes/tpmdd/master
# Cherry-pick and apply TEE features patch-set from this PR[3]
# Apply this Linux trusted keys patch-set.

# Now move on to build the source code
$ cd <optee-project>/build
# Apply attached "keyctl_change" patch
$ patch -p1 < keyctl_change
$ make -j`nproc`
CFG_IN_TREE_EARLY_TAS=trusted_keys/f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c

# Run QEMU setup
$ make run-only
# Type "c" on QEMU console to continue boot

# Now there should be two virtual consoles up, one for OP-TEE and
other for Linux
# On Linux console, you can play with "keyctl" utility to have trusted
and encrypted keys based on TEE.

Do let me know in case you are stuck while following the above steps.

[1] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
[2] https://optee.readthedocs.io/en/latest/building/prerequisites.html#prerequisites
[3] https://lkml.org/lkml/2020/5/4/1062

-Sumit

> /Jarkko
>

--00000000000021218505a596a2dc
Content-Type: application/octet-stream; name=keyctl_change
Content-Disposition: attachment; filename=keyctl_change
Content-Transfer-Encoding: base64
Content-ID: <f_ka6g56md0>
X-Attachment-Id: f_ka6g56md0

ZGlmZiAtLWdpdCBhL2NvbW1vbi5tayBiL2NvbW1vbi5tawppbmRleCBhZWI3YjQxLi42NjNlNTI4
IDEwMDY0NAotLS0gYS9jb21tb24ubWsKKysrIGIvY29tbW9uLm1rCkBAIC0yMjksNiArMjI5LDcg
QEAgQlIyX1BBQ0tBR0VfT1BURUVfVEVTVF9TREsgPz0gJChPUFRFRV9PU19UQV9ERVZfS0lUX0RJ
UikKIEJSMl9QQUNLQUdFX09QVEVFX1RFU1RfU0lURSA/PSAkKE9QVEVFX1RFU1RfUEFUSCkKIEJS
Ml9QQUNLQUdFX1NUUkFDRSA/PSB5CiBCUjJfVEFSR0VUX0dFTkVSSUNfR0VUVFlfUE9SVCA/PSAk
KGlmICQoQ0ZHX05XX0NPTlNPTEVfVUFSVCksdHR5QU1BJChDRkdfTldfQ09OU09MRV9VQVJUKSx0
dHlBTUEwKQorQlIyX1BBQ0tBR0VfS0VZVVRJTFMgOj0geQogCiAjIEFsbCBCUjJfKiB2YXJpYWJs
ZXMgZnJvbSB0aGUgbWFrZWZpbGUgb3IgdGhlIGVudmlyb25tZW50IGFyZSBhcHBlbmRlZCB0bwog
IyAuLi9vdXQtYnIvZXh0cmEuY29uZi4gQWxsIHZhbHVlcyBhcmUgcXVvdGVkICIuLi4iIGV4Y2Vw
dCB5IGFuZCBuLgpkaWZmIC0tZ2l0IGEva2NvbmZpZ3MvcWVtdS5jb25mIGIva2NvbmZpZ3MvcWVt
dS5jb25mCmluZGV4IDM2OGMxOGEuLjgzMmFiNzQgMTAwNjQ0Ci0tLSBhL2tjb25maWdzL3FlbXUu
Y29uZgorKysgYi9rY29uZmlncy9xZW11LmNvbmYKQEAgLTIwLDMgKzIwLDUgQEAgQ09ORklHXzlQ
X0ZTPXkKIENPTkZJR185UF9GU19QT1NJWF9BQ0w9eQogQ09ORklHX0hXX1JBTkRPTT15CiBDT05G
SUdfSFdfUkFORE9NX1ZJUlRJTz15CitDT05GSUdfVFJVU1RFRF9LRVlTPXkKK0NPTkZJR19FTkNS
WVBURURfS0VZUz15Cg==
--00000000000021218505a596a2dc--
