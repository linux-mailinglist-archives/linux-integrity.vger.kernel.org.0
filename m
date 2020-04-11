Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8601A537E
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Apr 2020 21:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgDKTFX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Apr 2020 15:05:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37169 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDKTFX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Apr 2020 15:05:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so5867680wrm.4;
        Sat, 11 Apr 2020 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJ7hnNFhk/mxUWoU/yAmjq9znKBHBG2b6AkM8126D5U=;
        b=TH+P+l7rsmuAQ6hTbNyVs6lp/hvmL+1S5REtZKsQKG+cwgHbKS3IBC2ehBRCGXd8FW
         Uh0YXgBhhPW27yaWBe9P8HimTmsswTX2YuhIOx3TOJO4YmOY9R23AROxbqdS/A6h42uY
         BCfEbhzll/JNHX6FNa9/TMKY6D39S+cpSly35YyWP+2clduPrPeV47G5hW47iBhUEeq4
         33wLGfK+gcHuso5D2IxMemQrVHg99hfHltH+Uj7E3djXSAcHsrZUKdyXLbMoeLYrT1eG
         Bw6ACWVsftDd1f9WVJU7qVN04QDsNXQfoshiRFWRDmFjKu7rGG+lJNnJbgd2b2lT2zGN
         zkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJ7hnNFhk/mxUWoU/yAmjq9znKBHBG2b6AkM8126D5U=;
        b=VO7vX7ZGk8rDoQlsNT8Ds/pxgkyCJ7CPDWYVCL3qnh/oBnuDndcPYbEwajKm++VOQE
         D00hs9D6BJ5OAe9cmwURmw0T7445fsHwbXIgTPOEYjNEFepPOH/HuFt0RR0bSsvflXgM
         1w3+OGrW1YxpLDEGEukFMhbzMCO0CEJem/cASjkRgPtNIJnmv0pfNdvBrh7vbRhrpL9h
         Z4LTfltNwjP+7oraWvLvEA0Y5nwPJwYbwtGNIc1JtohTQNOyd2urH1e1j0nQ2qN92v0L
         dzniNhhiNBw02Q6Wtd1FA1q4NvasJ2OsvwVb/YccoP4VQj+URcQE6bIGcTd4/dHaz8yW
         x70w==
X-Gm-Message-State: AGi0PuaRHx4sxpGpYvkVM2EavMfxECfjRBJNrP66H6qO1qZLFL4NVHeD
        +rIKafyLylGQpD+WxQ+RrMeta5nXv8CDVox3iOg=
X-Google-Smtp-Source: APiQypJfCKuBECqeq8oDEtF/Z00WuOl3uUYTl8M4KrnDNnIXPvozYKdyuDjc253Vbg821RFqmPypKE6hVppwiaGCPwU=
X-Received: by 2002:a5d:4111:: with SMTP id l17mr11678394wrp.271.1586631919839;
 Sat, 11 Apr 2020 12:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
In-Reply-To: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Sat, 11 Apr 2020 15:05:07 -0400
Message-ID: <CAB9W1A1=JyOV3-+6jn3xX-M+GKWBB2cCNh-VWB_kzf+YiR_d2Q@mail.gmail.com>
Subject: Re: [RFC] IMA: New IMA measurements for dm-crypt and selinux
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>, dm-devel@redhat.com,
        James Morris <jmorris@namei.org>, chpebeni@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@microsoft.com,
        sashal@kernel.org, suredd@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 8, 2020 at 6:28 AM Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
> Measuring SELinux status and various SELinux policies can help ensure
> mandatory access control of the system is not compromised.
<snip>
> B. Measuring selinux constructs:
>      We propose to add an IMA hook in enforcing_set() present under
>      security/selinux/include/security.h.
>      enforcing_set() sets the selinux state to enforcing/permissive etc.
>      and is called from key places like selinux_init(),
>      sel_write_enforce() etc.
>      The hook will measure various attributes related to selinux status.
>      Majority of the attributes are present in the struct selinux_state
>      present in security/selinux/include/security.h
>      e.g.
>      $sestatus
>             SELinux status:              enabled
>             SELinuxfs mount:             /sys/fs/selinux
>             SELinux root directory:      /etc/selinux
>             Loaded policy name:          default
>             Current mode:                permissive
>             Mode from config file:       permissive
>             Policy MLS status:           enabled
>             Policy deny_unknown status:  allowed
>             Memory protection checking:  requested (insecure)
>             Max kernel policy version:   32
>
>      The above attributes will be serialized into a set of key=value
>      pairs when passed to IMA for measurement.
>
>      Proposed Function Signature of the IMA hook:
>      void ima_selinux_status(void *selinux_status, int len);

This won't detect changes to any of these state variables via a kernel
write vulnerability,
so it would be good to provide a way to trigger measurement of the
current values on
demand.
You'll also likely want to measure parts of the child structures of
selinux_state, e.g. selinux_ss,
especially selinux_map and policydb.  You can simplify measurement of
the policydb by
serializing it first via policydb_write() and hashing the result. I
suppose one question is whether you can do all of this
already from userspace by just having userspace read
/sys/fs/selinux/enforce, /sys/fs/selinux/policy, etc.
