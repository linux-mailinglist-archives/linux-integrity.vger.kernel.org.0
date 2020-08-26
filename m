Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F9F253015
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Aug 2020 15:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgHZNk5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Aug 2020 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbgHZNkz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Aug 2020 09:40:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A9C061574
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2020 06:40:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m22so2406310ljj.5
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2020 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCF+Nj4dKHgqt1pa+dOzlep+EbJH5SgSIw1BSq3CsDk=;
        b=nGQdudSEeU5VCPRh6Bu7KFt9Rz1+xvDUz2w6b0n2bW6LxI2NWVgLWNYkDD5c9GxVYZ
         FeSs/dWJ+j4KtVY1c9RMl2IjPmJJd2ZuhvX99m0G1lDxlu6TCYsDg6VPhwJjMXgpz0xC
         /ozhGt8646JKEmTUgaVilpKa0zNCyrsiBfsXwf48ss5teoy3+VgE6tyIRMR8DIFKBsfe
         kiwzc1iNXKAhlQshtS1Y+gGbI0YY933RAZXaveBoPD1lXG16Orvv6oKPDueLd1X1mgdL
         GATO9sl9kGt7gX+8cZfwf9AIHqWPkhxLEJS4SDVV83pz2XHj6QrwTNQ1flO3esiLunTI
         kZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCF+Nj4dKHgqt1pa+dOzlep+EbJH5SgSIw1BSq3CsDk=;
        b=GNIUY5yIUCA8gA+L+fXxbesg3P+8R4byqCuNMHsCFcTmLh56TCkCfnVRTTBTS6WlNV
         NtIXWTtHPJWyTb7nr88ScCsRTeIpQlFDxmm9scXqEJ/Bh0sr7ppwQ2AENgVsdvVZelLp
         yudUauKuNVUh9E8wqr+xrfspvzsCbDBC3GeG5oWLnrPr6uosbGAdiRt839uXepm1sZJu
         RQNmwiEUQqiFzwmRMBsWZSwQF9SB/2WKJdRYUwWLmzh1JjDvrSK40qevbtZTUS/Vw+dm
         ozlENZd6twUNovDEp7Wis+7xPsoyR/b/bQ+96tA/G+6QUsp1jqRbSK8lmByVnRYHhF2i
         +hkA==
X-Gm-Message-State: AOAM531Payn0JINTFxQ1vtmWbMdX+MZF2Vz81iZteUt92azosop9klwg
        fMaC/saQ+mXkILIRG++Xlwkg+g3DqHS82Hp2VRI=
X-Google-Smtp-Source: ABdhPJy2vc+16HOVTYXQIshWpn1K6aWj8wRVcaVvwmWFSurd/Uea8f2rhZBvq5Oyz1wsSZEnKwgClnoFsJ++D0YiEI4=
X-Received: by 2002:a05:651c:155:: with SMTP id c21mr7735938ljd.453.1598449251616;
 Wed, 26 Aug 2020 06:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <436e3951-d6d5-014a-dde1-8a6398dfe7a1@linux.microsoft.com>
 <57e0095a-ff6f-e5dc-6250-1320bd6518cb@linux.microsoft.com> <CAE=NcrYOy56_mRNUvvOBX5v=zGsNXwqmz9Q6q3Ovu0vfCRKBpQ@mail.gmail.com>
In-Reply-To: <CAE=NcrYOy56_mRNUvvOBX5v=zGsNXwqmz9Q6q3Ovu0vfCRKBpQ@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 26 Aug 2020 16:40:40 +0300
Message-ID: <CAE=NcraZDd=8GPGYYuKOVtk++yk5iquPHkCa_h4VbUyH-OP6AQ@mail.gmail.com>
Subject: Re: [RFC] ima: export the measurement list when needed
To:     Raphael Gianotti <raphgi@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Content-Type: multipart/mixed; boundary="000000000000d5a46b05adc7f753"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--000000000000d5a46b05adc7f753
Content-Type: text/plain; charset="UTF-8"

Hi,

Attached a variant of the patch from that time that only does the
element free and relies on the userspace reading the data.

The reason why I stopped working on this at the time was that below
was sufficient for my needs. However, after a discussion between Mimi
and myself (based on a suggestion by Amir Goldstein) we realized that
we could do something considerably more elegant through vfs_tmpfile.
It's also much more work.

The way this could probably work the best is if we would implement a
new allocator that would pull pages from a vmarea tied to a
vfs_tmpfile and the file could be opened by the kernel itself during
the ima init. Now if all the measurement list data blobs would be
allocated through this allocator the pages would never be permanently
resident in the kernel, they would only visit the memory for a while
when someone reads the data. If done this way the allocator probably
does not even need a 'free' and the mm code would do all the real work
pushing the data out.

The benefits would be that no-one would ever have to poll from
userspace (kernel does not depend on the userspace to work) and we
would never OOM because of IMA as long as the filesystem is writable.
Also we would never lose any data as long as the file system is
functioning.

Thoughts?


--
Janne

On Wed, Aug 26, 2020 at 11:14 AM Janne Karhunen
<janne.karhunen@gmail.com> wrote:
>
> Hi Raphael,
>
> Sorry I missed the reply. I'm not working on this right now, feel free
> to grab. Please copy me with the results, thank you.
>
>
> --
> Janne
>
> On Tue, Aug 18, 2020 at 12:30 AM Raphael Gianotti
> <raphgi@linux.microsoft.com> wrote:
> >
> >
> > Hi Janne,
> >
> > Subject: Re: [RFC] ima: export the measurement list when needed
> > > Date: Wed, 18 Dec 2019 17:11:22 +0200
> > > From: Janne Karhunen <janne.karhunen@gmail.com>
> > > To: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
> > > CC: Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
> > > monty.wiseman@ge.com
> > >
> > > Hi,
> > >
> > > Have in mind that below is the first trial draft that booted and
> > > seemingly accomplished the task once, it was not really tested at all
> > > yet. I will make a polished and tested version if people like the
> > > concept.
> > >
> > > Note that the code (almost) supports pushing and pulling of the
> > > entries. This variant is a simple pull given that the list size is
> > > above the defined limits. Pushing can be put in place if the recursion
> > > with the list extend_list_mutex is cleared, maybe this could be done
> > > via another patch later on when we have a workqueue for the export
> > > task? The workqueue might be the best context for the export job since
> > > clearing the list is a heavy operation (and it's not entirely correct
> > > here AFAIK, there is no rcu sync before the template free).
> > >
> > >
> > > -- Janne
> > >
> > > On Wed, Dec 18, 2019 at 2:53 PM Janne Karhunen
> > > <janne.karhunen@gmail.com> wrote:
> > >>
> > >> Some systems can end up carrying lots of entries in the ima
> > >> measurement list. Since every entry is using a bit of kernel
> > >> memory, add a new Kconfig variable to allow the sysadmin to
> > >> define the maximum measurement list size and the location
> > >> of the exported list.
> > >>
> > >> The list is written out in append mode, so the system will
> > >> keep writing new entries as long as it stays running or runs
> > >> out of space. File is also automatically truncated on startup.
> > >>
> > >> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> > >> ---
> > >>  security/integrity/ima/Kconfig     |  10 ++
> > >>  security/integrity/ima/ima.h       |   7 +-
> > >>  security/integrity/ima/ima_fs.c    | 178 +++++++++++++++++++++++++++++
> > >>  security/integrity/ima/ima_queue.c |   2 +-
> > >>  4 files changed, 192 insertions(+), 5 deletions(-)
> >
> > I've been looking into a solution to this same issue you started some
> > work on. I was wondering if you are still working on it. I was
> > considering taking your initial prototyping on this and extending it
> > into a final solution, but I wanted to reply here first and check if you
> > are currently working on this.
> >

--000000000000d5a46b05adc7f753
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ima-allow-the-measurement-list-flush.patch"
Content-Disposition: attachment; 
	filename="0001-ima-allow-the-measurement-list-flush.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kebe7nv20>
X-Attachment-Id: f_kebe7nv20

RnJvbSBiZTEyMGExNWM4ZDgxNjU1YmYxMTIzMzRlMzI3OWIxOTQxNWMyY2EyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW5uZSBLYXJodW5lbiA8amFubmUua2FyaHVuZW5AZ21haWwu
Y29tPgpEYXRlOiBNb24sIDE2IERlYyAyMDE5IDEyOjU5OjMwICswMjAwClN1YmplY3Q6IFtQQVRD
SCB2M10gaW1hOiBhbGxvdyB0aGUgbWVhc3VyZW1lbnQgbGlzdCBmbHVzaAoKU29tZSBzeXN0ZW1z
IGNhbiBlbmQgdXAgY2FycnlpbmcgbG90cyBvZiBlbnRyaWVzIGluIHRoZSBpbWEKbWVhc3VyZW1l
bnQgbGlzdC4gU2luY2UgZXZlcnkgZW50cnkgaXMgdXNpbmcgYSBiaXQgb2Yga2VybmVsCm1lbW9y
eSwgYWxsb3cgdGhlIHN5c2FkbWluIHRvIGZyZWUgYW55IGFtb3VudCBvZiBlbnRyaWVzIGFuZApo
YW5kbGUgdGhlIGxpc3QgZXhwb3J0IG1hbnVhbGx5LgoKQ2hhbmdlbG9nOgp2MzoKLSBEZXBlbmQg
b24gdGhlIHVzZXJzcGFjZSBkb2luZyB0aGUgZmlsZSBleHBvcnQsIG9ubHkgYWxsb3cKICB0aGUg
bGlzdCBmbHVzaC4KClNpZ25lZC1vZmYtYnk6IEphbm5lIEthcmh1bmVuIDxqYW5uZS5rYXJodW5l
bkBnbWFpbC5jb20+Ci0tLQogc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWEuaCAgICAgICB8ICA2
ICstLQogc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZnMuYyAgICB8IDY1ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwogc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcXVldWUuYyB8
ICAyICstCiAzIGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWEuaCBiL3NlY3VyaXR5L2lu
dGVncml0eS9pbWEvaW1hLmgKaW5kZXggNjQzMTdkOTUzNjNlLi44MjFhMGYxZDgzMmYgMTAwNjQ0
Ci0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hLmgKKysrIGIvc2VjdXJpdHkvaW50ZWdy
aXR5L2ltYS9pbWEuaApAQCAtMTUzLDYgKzE1Myw3IEBAIGludCB0ZW1wbGF0ZV9kZXNjX2luaXRf
ZmllbGRzKGNvbnN0IGNoYXIgKnRlbXBsYXRlX2ZtdCwKIHN0cnVjdCBpbWFfdGVtcGxhdGVfZGVz
YyAqaW1hX3RlbXBsYXRlX2Rlc2NfY3VycmVudCh2b2lkKTsKIHN0cnVjdCBpbWFfdGVtcGxhdGVf
ZGVzYyAqbG9va3VwX3RlbXBsYXRlX2Rlc2MoY29uc3QgY2hhciAqbmFtZSk7CiBib29sIGltYV90
ZW1wbGF0ZV9oYXNfbW9kc2lnKGNvbnN0IHN0cnVjdCBpbWFfdGVtcGxhdGVfZGVzYyAqaW1hX3Rl
bXBsYXRlKTsKK3ZvaWQgaW1hX2ZyZWVfdGVtcGxhdGVfZW50cnkoc3RydWN0IGltYV90ZW1wbGF0
ZV9lbnRyeSAqZW50cnkpOwogaW50IGltYV9yZXN0b3JlX21lYXN1cmVtZW50X2VudHJ5KHN0cnVj
dCBpbWFfdGVtcGxhdGVfZW50cnkgKmVudHJ5KTsKIGludCBpbWFfcmVzdG9yZV9tZWFzdXJlbWVu
dF9saXN0KGxvZmZfdCBidWZzaXplLCB2b2lkICpidWYpOwogaW50IGltYV9tZWFzdXJlbWVudHNf
c2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpOwpAQCAtMTYzLDEwICsxNjQsNyBAQCBp
bnQgX19pbml0IGltYV9pbml0X2RpZ2VzdHModm9pZCk7CiBpbnQgaW1hX2xzbV9wb2xpY3lfY2hh
bmdlKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsIHVuc2lnbmVkIGxvbmcgZXZlbnQsCiAJCQkg
IHZvaWQgKmxzbV9kYXRhKTsKIAotLyoKLSAqIHVzZWQgdG8gcHJvdGVjdCBoX3RhYmxlIGFuZCBz
aGFfdGFibGUKLSAqLwotZXh0ZXJuIHNwaW5sb2NrX3QgaW1hX3F1ZXVlX2xvY2s7CitleHRlcm4g
c3RydWN0IG11dGV4IGltYV9leHRlbmRfbGlzdF9tdXRleDsKIAogc3RydWN0IGltYV9oX3RhYmxl
IHsKIAlhdG9taWNfbG9uZ190IGxlbjsJLyogbnVtYmVyIG9mIHN0b3JlZCBtZWFzdXJlbWVudHMg
aW4gdGhlIGxpc3QgKi8KZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2Zz
LmMgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9mcy5jCmluZGV4IGE3MWU4MjJhNmU5Mi4u
MTA0ZjgyOGI5NDQ0IDEwMDY0NAotLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9mcy5j
CisrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2ZzLmMKQEAgLTM2MCw2ICszNjAsNyBA
QCBzdGF0aWMgc3RydWN0IGRlbnRyeSAqYXNjaWlfcnVudGltZV9tZWFzdXJlbWVudHM7CiBzdGF0
aWMgc3RydWN0IGRlbnRyeSAqcnVudGltZV9tZWFzdXJlbWVudHNfY291bnQ7CiBzdGF0aWMgc3Ry
dWN0IGRlbnRyeSAqdmlvbGF0aW9uczsKIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICppbWFfcG9saWN5
Oworc3RhdGljIHN0cnVjdCBkZW50cnkgKmltYV9mbHVzaF9tZWFzdXJlbWVudHM7CiAKIGVudW0g
aW1hX2ZzX2ZsYWdzIHsKIAlJTUFfRlNfQlVTWSwKQEAgLTQ0Nyw2ICs0NDgsNjIgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgaW1hX21lYXN1cmVfcG9saWN5X29wcyA9IHsK
IAkubGxzZWVrID0gZ2VuZXJpY19maWxlX2xsc2VlaywKIH07CiAKK3N0YXRpYyBsb25nIGltYV9m
cmVlX2VudHJpZXMobG9uZyBlYykKK3sKKwlzdHJ1Y3QgaW1hX3F1ZXVlX2VudHJ5ICpxZSwgKmU7
CisJbG9uZyBjOworCisJYyA9IGF0b21pY19sb25nX3JlYWQoJmltYV9odGFibGUubGVuKTsKKwlp
ZiAoZWMgPiBjKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWMgPSAwOworCW11dGV4X2xvY2soJmlt
YV9leHRlbmRfbGlzdF9tdXRleCk7CisJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHFlLCBlLCAm
aW1hX21lYXN1cmVtZW50cywgbGF0ZXIpIHsKKwkJaWYgKGMrKyA+IGVjKQorCQkJYnJlYWs7CisK
KwkJaGxpc3RfZGVsX3JjdSgmcWUtPmhuZXh0KTsKKwkJYXRvbWljX2xvbmdfZGVjKCZpbWFfaHRh
YmxlLmxlbik7CisKKwkJbGlzdF9kZWxfcmN1KCZxZS0+bGF0ZXIpOworCQlpbWFfZnJlZV90ZW1w
bGF0ZV9lbnRyeShxZS0+ZW50cnkpOworCQlrZnJlZShxZSk7CisJfQorCW11dGV4X3VubG9jaygm
aW1hX2V4dGVuZF9saXN0X211dGV4KTsKKwlyZXR1cm4gYzsKK30KKworc3RhdGljIHNzaXplX3Qg
aW1hX2ZsdXNoX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxwLAorCQkJICAgICAgIGNvbnN0IGNoYXIg
X191c2VyICpidWYsCisJCQkgICAgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpCit7CisJ
Y2hhciBhbnVtWzMyXTsKKwlsb25nIG51bTsKKwlpbnQgZXJyOworCisJaWYgKCFjYXBhYmxlKENB
UF9TWVNfQURNSU4pKQorCQlyZXR1cm4gLUVQRVJNOworCWlmICghY291bnQgfHwgKGNvdW50ID49
IDMyKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisJbWVtc2V0KGFudW0sIDAsIDMyKTsKKworCWVyciA9
IGNvcHlfZnJvbV91c2VyKGFudW0sIGJ1ZiwgY291bnQpOworCWlmIChlcnIpCisJCXJldHVybiBl
cnI7CisJaWYgKGFudW1bY291bnQtMV0gPT0gJ1xuJykKKwkJYW51bVtjb3VudC0xXSA9IDA7CisJ
ZXJyID0ga3N0cnRvbChhbnVtLCAwLCAmbnVtKTsKKwlpZiAoZXJyKQorCQlyZXR1cm4gZXJyOwor
CisJcmV0dXJuIGltYV9mcmVlX2VudHJpZXMobnVtKTsKK30KKworc3RhdGljIGNvbnN0IHN0cnVj
dCBmaWxlX29wZXJhdGlvbnMgaW1hX2ZsdXNoX29wcyA9IHsKKwkud3JpdGUgPSBpbWFfZmx1c2hf
d3JpdGUsCit9OworCiBpbnQgX19pbml0IGltYV9mc19pbml0KHZvaWQpCiB7CiAJaW1hX2RpciA9
IHNlY3VyaXR5ZnNfY3JlYXRlX2RpcigiaW1hIiwgaW50ZWdyaXR5X2Rpcik7CkBAIC00OTEsNiAr
NTQ4LDEyIEBAIGludCBfX2luaXQgaW1hX2ZzX2luaXQodm9pZCkKIAlpZiAoSVNfRVJSKGltYV9w
b2xpY3kpKQogCQlnb3RvIG91dDsKIAorCWltYV9mbHVzaF9tZWFzdXJlbWVudHMgPQorCSAgICBz
ZWN1cml0eWZzX2NyZWF0ZV9maWxlKCJmbHVzaF9tZWFzdXJlbWVudHMiLCAwMjAwLCBpbWFfZGly
LAorCQkJCSAgIE5VTEwsICZpbWFfZmx1c2hfb3BzKTsKKwlpZiAoSVNfRVJSKGltYV9mbHVzaF9t
ZWFzdXJlbWVudHMpKQorCQlnb3RvIG91dDsKKwogCXJldHVybiAwOwogb3V0OgogCXNlY3VyaXR5
ZnNfcmVtb3ZlKHZpb2xhdGlvbnMpOwpAQCAtNTAwLDUgKzU2Myw3IEBAIGludCBfX2luaXQgaW1h
X2ZzX2luaXQodm9pZCkKIAlzZWN1cml0eWZzX3JlbW92ZShpbWFfc3ltbGluayk7CiAJc2VjdXJp
dHlmc19yZW1vdmUoaW1hX2Rpcik7CiAJc2VjdXJpdHlmc19yZW1vdmUoaW1hX3BvbGljeSk7CisJ
c2VjdXJpdHlmc19yZW1vdmUoaW1hX2ZsdXNoX21lYXN1cmVtZW50cyk7CisKIAlyZXR1cm4gLTE7
CiB9CmRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9xdWV1ZS5jIGIvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcXVldWUuYwppbmRleCA4NzUzMjEyZGRiMTguLjRlZWUw
YmJmMjY0NyAxMDA2NDQKLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcXVldWUuYwor
KysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9xdWV1ZS5jCkBAIC00Miw3ICs0Miw3IEBA
IHN0cnVjdCBpbWFfaF90YWJsZSBpbWFfaHRhYmxlID0gewogICogYW5kIGV4dGVuZGluZyB0aGUg
VFBNIFBDUiBhZ2dyZWdhdGUuIFNpbmNlIHRwbV9leHRlbmQgY2FuIHRha2UKICAqIGxvbmcgKGFu
ZCB0aGUgdHBtIGRyaXZlciB1c2VzIGEgbXV0ZXgpLCB3ZSBjYW4ndCB1c2UgdGhlIHNwaW5sb2Nr
LgogICovCi1zdGF0aWMgREVGSU5FX01VVEVYKGltYV9leHRlbmRfbGlzdF9tdXRleCk7CitERUZJ
TkVfTVVURVgoaW1hX2V4dGVuZF9saXN0X211dGV4KTsKIAogLyogbG9va3VwIHVwIHRoZSBkaWdl
c3QgdmFsdWUgaW4gdGhlIGhhc2ggdGFibGUsIGFuZCByZXR1cm4gdGhlIGVudHJ5ICovCiBzdGF0
aWMgc3RydWN0IGltYV9xdWV1ZV9lbnRyeSAqaW1hX2xvb2t1cF9kaWdlc3RfZW50cnkodTggKmRp
Z2VzdF92YWx1ZSwKLS0gCjIuMTcuMQoK
--000000000000d5a46b05adc7f753--
