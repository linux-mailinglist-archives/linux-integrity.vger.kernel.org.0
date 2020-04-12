Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4EAD1A5D6E
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Apr 2020 10:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgDLIPT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Apr 2020 04:15:19 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41593 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLIPT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Apr 2020 04:15:19 -0400
Received: by mail-il1-f194.google.com with SMTP id f82so2564546ilh.8;
        Sun, 12 Apr 2020 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/Lb56tGiXdOhLm4M0kNSqw6FPBoSkeoJ2b2tzoaiUg=;
        b=iRvO0GRYfEo4FFqysv7xd+IiXgg0sCKSfGiHmvfUxmpMGq6KSHM0FgxKyAerPrSXUy
         ygV2w/l83K4YkNx3WLdTN5oIQSbVKFKsHYjTJY9hCD26mBcf+XPK5/seWl+kUUqcJd/j
         QNgLhyQHicAa8q182Ay4mCTd7ZSSZnliZHzDse9zKEXKMZThNX93DXxHWMX/xth0KG+P
         56zSOOcfPOuykxyB3GhIV6/4JGfUgk7FhvHzES9vbVEQCS8p/Or9cogYC7jMTP9Yb3Hf
         Rw2h1jfTgxVbdwm/lQTETv9ln5tS6086/Vtk9Xmfz8JbkuIecdGuPQauxqD2mMIMQJ6S
         sSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/Lb56tGiXdOhLm4M0kNSqw6FPBoSkeoJ2b2tzoaiUg=;
        b=TkiWVOOkzDl+QnJtUDX7cZmJIoknklZH5QjxOWnbIXBGqcPnCweKEFL0HNUyCrQSOG
         Hz7TgDWZCmbLYMu0Lw1bnlrLORDU7PwCKiqdY0lHQRra7YLK0UXbE+4u3a3fBUaIeZw2
         +g22leqSBoxqAh7g3UtntcUOxUXmxi25i2WDL2V/273Fp0eTHOBvJY0KV/OrN6dSgcvX
         oPd5TEk50NcMXbUM45D5aA6ISIrmnMo5P169Xm7W8OLA0hzw7RiiHy+kKQm0T8Ec5b3X
         D6zUNuPRqI7OJK81MHXk+hRVh+63mDehvd44dcQojWhfLVr4+KULxBP1HcyTgnE/FC/H
         wPSg==
X-Gm-Message-State: AGi0PuYUGhMbl1soWbnDuc42eu6nqnvbCB9LqiVrpVXkH5trjmERHoDx
        dbo/8H8VkiZlxbbHd/UGyoFOA9us4th2NhiFRy2vycru6nk=
X-Google-Smtp-Source: APiQypLrgetzg3xkZ+c4aa3/NRG/TMq0oNUgTRtFJ+4YwTFwuFx2KOSYw7Q3K9sS6y5hElbohZU31ooLD7r7jKIxFiI=
X-Received: by 2002:a92:dc43:: with SMTP id x3mr4747407ilq.102.1586679317629;
 Sun, 12 Apr 2020 01:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com> <CAB9W1A1=JyOV3-+6jn3xX-M+GKWBB2cCNh-VWB_kzf+YiR_d2Q@mail.gmail.com>
In-Reply-To: <CAB9W1A1=JyOV3-+6jn3xX-M+GKWBB2cCNh-VWB_kzf+YiR_d2Q@mail.gmail.com>
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Sun, 12 Apr 2020 11:15:06 +0300
Message-ID: <CAP22eLGJbSvUU=W0Jp=gvOFv-nxLC8YTnta3OU2PKbh746MCkQ@mail.gmail.com>
Subject: Re: [RFC] IMA: New IMA measurements for dm-crypt and selinux
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
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

On Sat, Apr 11, 2020 at 10:07 PM Stephen Smalley
<stephen.smalley@gmail.com> wrote:
>
> On Wed, Apr 8, 2020 at 6:28 AM Tushar Sugandhi
> <tusharsu@linux.microsoft.com> wrote:
> > Measuring SELinux status and various SELinux policies can help ensure
> > mandatory access control of the system is not compromised.
> <snip>
> > B. Measuring selinux constructs:
> >      We propose to add an IMA hook in enforcing_set() present under
> >      security/selinux/include/security.h.
> >      enforcing_set() sets the selinux state to enforcing/permissive etc.
> >      and is called from key places like selinux_init(),
> >      sel_write_enforce() etc.
> >      The hook will measure various attributes related to selinux status.
> >      Majority of the attributes are present in the struct selinux_state
> >      present in security/selinux/include/security.h
> >      e.g.
> >      $sestatus
> >             SELinux status:              enabled
> >             SELinuxfs mount:             /sys/fs/selinux
> >             SELinux root directory:      /etc/selinux
> >             Loaded policy name:          default
> >             Current mode:                permissive
> >             Mode from config file:       permissive
> >             Policy MLS status:           enabled
> >             Policy deny_unknown status:  allowed
> >             Memory protection checking:  requested (insecure)
> >             Max kernel policy version:   32
> >
> >      The above attributes will be serialized into a set of key=value
> >      pairs when passed to IMA for measurement.
> >
> >      Proposed Function Signature of the IMA hook:
> >      void ima_selinux_status(void *selinux_status, int len);
>
> This won't detect changes to any of these state variables via a kernel
> write vulnerability,
> so it would be good to provide a way to trigger measurement of the
> current values on
> demand.
> You'll also likely want to measure parts of the child structures of
> selinux_state, e.g. selinux_ss,
> especially selinux_map and policydb.  You can simplify measurement of
> the policydb by
> serializing it first via policydb_write() and hashing the result. I
> suppose one question is whether you can do all of this
> already from userspace by just having userspace read
> /sys/fs/selinux/enforce, /sys/fs/selinux/policy, etc.

It sees to me that  LKRG (kernel run time guard)  takes the role of
measuring kernel structures.  Perhaps you need to consult with LKRG
guys.
Lev.
