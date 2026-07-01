Return-Path: <linux-integrity+bounces-9867-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jQ63MrcDRWow5AoAu9opvQ
	(envelope-from <linux-integrity+bounces-9867-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 14:10:31 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7056ED125
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 14:10:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Lk0z/ZQB";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9867-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9867-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A1E0301A924
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2026 12:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413D42DFEC;
	Wed,  1 Jul 2026 12:08:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715136A35E;
	Wed,  1 Jul 2026 12:08:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907706; cv=none; b=UDXANltcYufCks5Us9lBjyhc+ETxMhAyCYURfWEQ1ipJ1b+FmeVAqngoCyrA3rDv2fOtv9PQ/RyJlUYkgUaFQ9fcAWI41Dp//srW8lza+cpkpStiOnbXBMobog80WyTAxkyySAQ3Pfk2g1WGGEpVvaIxma1ADS/lJJZYpeEPdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907706; c=relaxed/simple;
	bh=Ws0OJJlXpWxtml1Fc1O6tOYzQ5IvL7u+woquuLfUx6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lzGF5p2BiNYnnRfLBNY6wxEZ6hNs3r47gKlZONgv+LuOl4TZc0Pvn7GvnJClICrVcR0d04jOqLJTAKoyFWQwqU6MljsXmubR4fqobT+VFWrQ9c2l2bF7psZ0AOA/asfmVYSRLlHHCf0PGJCvSAwk5L2VU8ubj8xbeZOz7Dggf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk0z/ZQB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2AA1F000E9;
	Wed,  1 Jul 2026 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907704;
	bh=C0eRNTRNun4PKYWrdIhick5RVmD+08hh2iy99USv2dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Lk0z/ZQBNWuYtX5yOP2RB8ff5+3SHNmHArT5mGIRw4gKVvkZg6/TGWpPSDRn1vUoB
	 7h0Svchp8RQk9jeBIpu2cmGAS9pqWjEe0cXuGkXpbg3WI8WFwI3qamF0M9B47NrSdz
	 6lRu0WURG8w7jW9SaeLmjXJfjZRQ0eUtzUCAPDif+6m2TOTUES5AeQbvQvLoXcrEPD
	 RaZr333OdeOtghfigKxJow6PwKBVRJfWhkE3Yw19SmPSfdyjHW8185kmrdE4IFO/cc
	 8a/fJUJ/MUCdG9cBe5+Kr0uaV07WwcQQgzZILuVCnyN0yYTCvZJBiKEjyAyuvMWiOR
	 lgFC+aGDyBsdw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tao Liu <ltao@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Baoquan He <bhe@redhat.com>,
  kexec@lists.infradead.org,  pjw@kernel.org,  palmer@dabbelt.com,
  aou@eecs.berkeley.edu,  alex@ghiti.fr,  Mimi Zohar <zohar@linux.ibm.com>,
  Roberto Sassu <roberto.sassu@huawei.com>,  Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,  Eric Snowberg <eric.snowberg@oracle.com>,
  linux-integrity@vger.kernel.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix a NULL pointer reference in
 machine_kexec_prepare
In-Reply-To: <CAO7dBbXzs2pMrVuJ3qUVT2KYNh9RysOOWy_HPTmCY3gYUh9LDQ@mail.gmail.com>
 (Tao
	Liu's message of "Wed, 1 Jul 2026 15:29:44 +1200")
References: <20260529032739.13264-2-ltao@redhat.com>
	<CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
	<CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com>
	<2vxzh5mlk3bd.fsf@kernel.org>
	<CAO7dBbXzs2pMrVuJ3qUVT2KYNh9RysOOWy_HPTmCY3gYUh9LDQ@mail.gmail.com>
Date: Wed, 01 Jul 2026 14:08:20 +0200
Message-ID: <2vxzy0fuhpzf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9867-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ltao@redhat.com,m:pratyush@kernel.org,m:bhe@redhat.com,m:kexec@lists.infradead.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:linux-integrity@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pratyush@kernel.org,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,lists.infradead.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,linux.ibm.com,huawei.com,gmail.com,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE7056ED125

On Wed, Jul 01 2026, Tao Liu wrote:

> Hi Pratyush,
>
> On Mon, Jun 29, 2026 at 11:13=E2=80=AFPM Pratyush Yadav <pratyush@kernel.=
org> wrote:
>>
>> +Cc IMA maintainers
>>
>> On Fri, Jun 26 2026, Baoquan He wrote:
>>
>> > Add kexec ML to CC.
>> >
>> > On Fri, Jun 26, 2026 at 7:46=E2=80=AFAM Tao Liu <ltao@redhat.com> wrot=
e:
>> >>
>> >> Kindly ping, any comments?
>> >>
>> >> Thanks,
>> >> Tao Liu
>> >>
>> >> On Fri, May 29, 2026 at 3:35=E2=80=AFPM Tao Liu <ltao@redhat.com> wro=
te:
>> >> >
>> >> > A NULL pointer reference issue is noticed in riscv's machine_kexec_=
prepare,
>> >> > where image->segment[i].buf might be NULL and copied unchecked.
>> >> >
>> >> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
>> >> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
>> >> > but kbuf.buffer is NULL.
>> >> >
>> >> > Fix this by simply adding a check before copy.
>> >> >
>> >> > Signed-off-by: Tao Liu <ltao@redhat.com>
>> >> > ---
>> >> >  arch/riscv/kernel/machine_kexec.c | 3 +++
>> >> >  1 file changed, 3 insertions(+)
>> >> >
>> >> > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/=
machine_kexec.c
>> >> > index 2306ce3e5f22..d81d576f9cb5 100644
>> >> > --- a/arch/riscv/kernel/machine_kexec.c
>> >> > +++ b/arch/riscv/kernel/machine_kexec.c
>> >> > @@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
>> >> >                 if (image->segment[i].memsz <=3D sizeof(fdt))
>> >> >                         continue;
>> >> >
>> >> > +               if (image->segment[i].buf =3D=3D NULL)
>> >> > +                       continue;
>> >> > +
>> >
>> > This is a good fix, maybe we can add code comments to explain it as
>> > below, just for reference.
>> >
>> >                /*
>> >                 * Some segments (e.g. IMA) reserve space but have no b=
uffer
>> >                 * loaded yet. Skip them as they cannot contain an FDT.
>> >                 */
>> > And is there any other place where the similar issue exists? e.g on Lo=
ongArch?
>> >
>> > Other than above concerns, this patch looks good to me:
>> >
>> > Acked-by: Baoquan He <bhe@redhat.com>
>>
>> Yeah, the patch LGTM to me too.
>>
>> Acked-by: Pratyush Yadav <pratyush@kernel.org>
>>
>> Although I think IMA can make this a bit easier to understand. First, in
>> ima_add_kexec_buffer() it should set kbuf.buffer to NULL and kbuf.bufsz
>> to 0 explicitly instead of using kexec_buffer and kexec_buffer_size
>> which are initialized to NULL and 0, but never updated. Using the
>> variables here adds an extra level of indirection.
>>
>> Also, perhaps we should add a comment in ima_add_kexec_buffer() about
>> how this all works, since where the IMA buffer lives and where it gets
>> updated it fairly complicated and took me some time to piece together.
>
> Thanks for your patch review and suggestions! I agree with your point
> on the IMA part, I was confused by the code too, e.g in
> ima_add_kexec_buffer():
>
> void *kexec_buffer =3D NULL;
> kbuf.buffer =3D kexec_buffer;
> ret =3D kexec_add_buffer(&kbuf);
> if (ret) {
>     pr_err("Error passing over kexec measurement buffer.\n");
>     vfree(kexec_buffer);
>     return;
> }
>
> Do we need to vfree(kexec_buffer)? When kexec_buffer is NULL and seems
> never get updated.
>
> I'm not familiar with IMA code, maybe there is a reason which I'm unaware=
 of...

I think it is just leftover from refactors. kexec_buffer used to point
to an actual buffer at some point and refactors to the function left
them always NULL but never removed them.

--=20
Regards,
Pratyush Yadav

