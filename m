Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47555B7363
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2019 08:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbfISGsG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Sep 2019 02:48:06 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44276 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbfISGsG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Sep 2019 02:48:06 -0400
Received: by mail-lj1-f169.google.com with SMTP id m13so2341917ljj.11
        for <linux-integrity@vger.kernel.org>; Wed, 18 Sep 2019 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQ74i7jMfFV1EW/qaEkp9OdMKSet+fmNgopOKpWlDMA=;
        b=kDZtUPSul7z6BJvVGvl7iL10tYZ1X9Wy9r9WrZRvI0otdnu6qMNwGdFDvMjN3oPHIN
         mBWNWver+58TGVuKZOVcZb4oKaWKIpEii8etZU7vLWN1HUlUetSbEJ0bOATnpwb+cljn
         8jxJq71NU85+9Jx2b1Xk/FTy1WIajxZ8MDfXFXMY2ci1eV9fpuvFz9yI0bs8yuLya+Nk
         0fxQDqydhtMczGEVE5FDF8w/LVm4dlv8EpeWkgK1WmvIRp4uHa1ZmqTSuH2Oe8eIScQA
         MnV7O0u/NzvXD50gq7p5neB1FaWseY+IOI0Vupv2I5D04wQf/Zsv8l6DuY4qXtrrJ+Q0
         Gp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQ74i7jMfFV1EW/qaEkp9OdMKSet+fmNgopOKpWlDMA=;
        b=p4BjYzJbTnSEGkL5t+r9gEiULiHragAOl0h3dwMN43xa+9D138UeWOgZuGOBJfNdrB
         WM/PnIY9ZwPSGAeCbg0W+tFDxehqiQs876Yidbq24ObghO5HPAVr0HiNXpEq43Gy+YfE
         SgI50DeTanyQIhKUvXHOxvegykZOyHqqzMFRjgRab3moP9Hcx0bgPtqTzH+H9AhrIxV4
         jvOT2WgPVZ7NqaWNtuCS8kk1zG0muSjKjvuDuub7lUupiyoedyfLx2TNlkmvoYYVdbIy
         ImqLEGDx2tR5YOA/qE+y0/W2+ESuVWiIkWKSCFd/NCUGvFRzpn3z+tOykXmNfGIKYRGb
         lqgg==
X-Gm-Message-State: APjAAAWlJOb6I4hf4pAhSnC6FcRn2rdHlbGVZaUBfpAVbtVob/wcpBe6
        AxiJUyZ9cDOieP3JL56bMeQ8BXCZJ49LcVU8Gg8=
X-Google-Smtp-Source: APXvYqxE3GulFVU8kBs6ObsttFIbC54A0ZdRsL7P8q4MMJCvHHFksKFOIZ++6kqBU/bevyB+6mq8th1/z/BIZAgaUcI=
X-Received: by 2002:a2e:b0c2:: with SMTP id g2mr4281955ljl.217.1568875684339;
 Wed, 18 Sep 2019 23:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
 <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
 <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com> <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
 <20190917124533.GD6762@mit.edu> <1568732169.11799.18.camel@HansenPartnership.com>
 <CAE=NcrZySAMJZe8Y9AfF2T3zoZqDe_HC4e7kD6eOkZMGBmSMOQ@mail.gmail.com> <1568821962.5817.17.camel@HansenPartnership.com>
In-Reply-To: <1568821962.5817.17.camel@HansenPartnership.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 19 Sep 2019 09:47:52 +0300
Message-ID: <CAE=NcrbHLU9=6yv9XwsP6PDMcWNAp5QUML5UKhj6vjZkqN=PbQ@mail.gmail.com>
Subject: Re: IMA on remote file systems
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 18, 2019 at 6:53 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> Mutability for integrity checked executables/data is problematic.  With
> IMA you have to update the file and the xattr and make sure nothing
> touches it before you've completed all the updates otherwise you get an
> integrity check failure.  This can work if your mutation is simply a
> distro update, but it's really hard to do if the file is constantly
> undergoing mutation because the window where the integrity check fails
> is huge ... thus it depends on your use case for mutability.

Right, but try those patches I posted. They mostly address this, even
android mmap'd databases seem to stay pretty well up to date and the
performance is not entirely destroyed either if tuned a bit.


--
Janne
