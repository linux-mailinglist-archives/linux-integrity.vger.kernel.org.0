Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B5124135E
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Aug 2020 00:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHJWri (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Aug 2020 18:47:38 -0400
Received: from smtp-190e.mail.infomaniak.ch ([185.125.25.14]:39725 "EHLO
        smtp-190e.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbgHJWri (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Aug 2020 18:47:38 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BQWLw2sdNzlhVPK;
        Tue, 11 Aug 2020 00:47:36 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BQWLr3MG5zlh8TP;
        Tue, 11 Aug 2020 00:47:32 +0200 (CEST)
Subject: Re: [PATCH v7 0/7] Add support for O_MAYEXEC
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Laight <David.Laight@aculab.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20200723171227.446711-1-mic@digikod.net>
 <202007241205.751EBE7@keescook>
 <0733fbed-cc73-027b-13c7-c368c2d67fb3@digikod.net>
 <20200810202123.GC1236603@ZenIV.linux.org.uk>
 <30b8c003f49d4280be5215f634ca2c06@AcuMS.aculab.com>
 <20200810222838.GF1236603@ZenIV.linux.org.uk>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <2531a0e8-5122-867c-ba06-5d2e623a3834@digikod.net>
Date:   Tue, 11 Aug 2020 00:47:32 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200810222838.GF1236603@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/08/2020 00:28, Al Viro wrote:
> On Mon, Aug 10, 2020 at 10:09:09PM +0000, David Laight wrote:
>>> On Mon, Aug 10, 2020 at 10:11:53PM +0200, Micka�l Sala�n wrote:
>>>> It seems that there is no more complains nor questions. Do you want me
>>>> to send another series to fix the order of the S-o-b in patch 7?
>>>
>>> There is a major question regarding the API design and the choice of
>>> hooking that stuff on open().  And I have not heard anything resembling
>>> a coherent answer.
>>
>> To me O_MAYEXEC is just the wrong name.
>> The bit would be (something like) O_INTERPRET to indicate
>> what you want to do with the contents.

The properties is "execute permission". This can then be checked by
interpreters or other applications, then the generic O_MAYEXEC name.

> 
> ... which does not answer the question - name of constant is the least of
> the worries here.  Why the hell is "apply some unspecified checks to
> file" combined with opening it, rather than being an independent primitive
> you apply to an already opened file?  Just in case - "'cuz that's how we'd
> done it" does not make a good answer...
> 

That is not the case, see
https://lore.kernel.org/lkml/917bb071-8b1a-3ba4-dc16-f8d7b4cc849f@digikod.net/
