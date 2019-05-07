Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74578163DE
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2019 14:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEGMnM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 May 2019 08:43:12 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:38071 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGMnM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 May 2019 08:43:12 -0400
Received: by mail-lf1-f43.google.com with SMTP id y19so4167402lfy.5
        for <linux-integrity@vger.kernel.org>; Tue, 07 May 2019 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=X5P2X74lmt0BIStcUfA6DKaQQcwJ1Sx5PCgcVMhznTI=;
        b=orEMXwSls6nZQz5cjDE6PsDYZSt6paWXzevUvaoCTZEQBChrH8D1YG0+fyKwC5BOB4
         2tdHyXl2Pjg7vVEUZ2VJqSPjKrtWAxSQpYN0giNXLKwkefcZVDGUS9EsPGUvEs+5GwFA
         jkL1zgR+N6C23NaCDtVnP253TAGwaZm85VTt+LB63uFkAnxkNh0A2SxRNbgr4sVBfZAC
         AQDIkYk40kUL0OlQJo2dnC013DcHXi/HRWQETMbO7KJgK5wTtSl46svKeDgHMjhvVRnX
         tcmnvPecSZU2MxSYBj2lMLCeebdtH6dMVODfBz0jTYsXEDn7RVx8oehmBcyirIJP7mC7
         OOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=X5P2X74lmt0BIStcUfA6DKaQQcwJ1Sx5PCgcVMhznTI=;
        b=E/A4Y8Tp8wrTCQAZMSywoRjG72To+n6CNYQ2sg9QHTEFUzx5GIziV2Z7QnE067U89b
         PHw9mwMaOnq8ZT/Or1cF9Zke0y2RotplaRsyQjCfKG6/fh2/flPEu3aRvYYLXK7eyZ4H
         igkYqZKs7EXH5FBllzVVDIEGM4nXkmwb7LSjkmWftTB6xYEJs3LtBnWFmosLc9NfYUJ0
         bbM0AyBxRvOwHhc0ZCyt4/wApbidavhPEFWG4tCH+OMplpukYP8D4l6lwROK+ftJRv7L
         4gmZ7yR125lXCDcJR4+6qFVImc5ERAw0BDfJNY0tCSBasHKea6bJ0QxCnWakdoxWkB7O
         jHjw==
X-Gm-Message-State: APjAAAXFdQUDCc8Xzr+DYclz6ZvU2VbFuF3metq02ykDACDzH+re5PZr
        LjrjlPvcPG+rS3rtuenVGQ1mCGnA5eCE9FT9UnKiiw==
X-Google-Smtp-Source: APXvYqwhtTbNn9IbkkkdNZRYuaV5T9m/ZwNS0mDyQQTgSBDdfrX3jBzBRWnAMKMrAVByHsBkhp7qqvjroJvNLYbzqsM=
X-Received: by 2002:a19:6a18:: with SMTP id u24mr11729879lfu.165.1557232990634;
 Tue, 07 May 2019 05:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190410145659.26347-1-janne.karhunen@gmail.com>
 <1554987784.7843.40.camel@linux.ibm.com> <CAE=NcrY_nwjdPoD+hk90CW93LTDattY_g-qQcqFQa=Xb7M+wPA@mail.gmail.com>
 <CAE=NcraxAJum=Uk77BoPXVkBDk3rwmXh80mLxy6pxrtUW_hpQg@mail.gmail.com>
 <1556805843.4134.15.camel@linux.ibm.com> <CAE=Ncrb4unTxeU=2jLb-KTqKXpK98vGFbrOxdcnjdfD_Ddk8ug@mail.gmail.com>
 <1556884105.4754.18.camel@linux.ibm.com> <CAE=Ncrbjq4MEZL5b6A6n8q2REsb_vG-TFMh54A+dgpQ8an4tyQ@mail.gmail.com>
In-Reply-To: <CAE=Ncrbjq4MEZL5b6A6n8q2REsb_vG-TFMh54A+dgpQ8an4tyQ@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 7 May 2019 15:42:59 +0300
Message-ID: <CAE=NcrYbX7k-uO_zaYa8qn-qO+5QeykmWH8YFfxAfoKYeLVJSg@mail.gmail.com>
Subject: Re: [PATCH] integrity: make 'sync' update the inode integrity state
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> > The question is whether this impacts your current set of patches?  We
> > really need to take this discussion back to the mailing list.  I've
> > responded to my original post with this info.
>
> Hmm, if we add the iversion query as you suggested the function can be
> added as a polling point just about anywhere. I added it in there now.

That said, before I chop that patch into pieces with individual
explanations (and fix the few remaining bugs that seemed to have
slipped in), hope you can let me know beforehand if the concept is ok
from your point of view. I understand it fully if this is too
intrusive as it goes all over the place. Just something we had to do
to keep the system rolling.


--
Janne
