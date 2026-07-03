Return-Path: <linux-integrity+bounces-9883-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CzBlN3fPR2qBfgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9883-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 17:04:23 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B202703B13
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 17:04:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="A42/s2/b";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9883-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9883-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E70B304D71C
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jul 2026 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850BB3F4DFE;
	Fri,  3 Jul 2026 14:59:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D552204C3B;
	Fri,  3 Jul 2026 14:59:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090794; cv=none; b=OH/RdAvov/ai9wq3jQJtQ1/t9o+C6wtcSrvXlritITwiiJFL81/2TNF69hC5Vu9VzIi4EJvKdNAEz1+JR1BDNIgsjecFz8WFo225sRCXCdmA6okd5Y4PcVUr8T0vdiluurxM1k7bJoJHslwzVn9VuzfELrxVGt1365I6cTuzUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090794; c=relaxed/simple;
	bh=iszMYG8/GDwOkWSLEKylfXpVUW/SGclSH7eygKWPKWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aV5NRhFAkWd9dcdLHVGKFdbn7EfT1/aSOsiAMbXcbDLD4LH6jdqvB24EzOzVGTt9cDnWcDFf5I2ovvlZnrrFcgvpQg4uz/nKTQzvYwLTCQhZ32qX4RJjGHDQNS1bkA6kIQsrYkruZwUMV8cvJZl+FgPYMqVxcCJD9112PJrMrck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A42/s2/b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D9A1F000E9;
	Fri,  3 Jul 2026 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783090793;
	bh=iszMYG8/GDwOkWSLEKylfXpVUW/SGclSH7eygKWPKWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=A42/s2/bFtKZ/AeyCtaD8M9riPQcpeAsT9Vo43MfiHhG9F1WIggDSFAJtzJAhb3tw
	 Kt4BoIupfmnqE+pDq0X3gliBgR0dXKNsjzgNQ0+tlHw7iS5oEdPvtcclnRGCGWN0/z
	 PDCB0OGy/uIIJ2o5wLDopD4zn5t0Lj7vDyvcqDwaY9p1I2nfrgmFcPgBFOUr50Tjz2
	 w4j6hBfSEoSmi+Wjcl+uDsONz/6TmdHORS4hA6hbG74zd/ckVMwUIrk8a8WjHdtw98
	 s45DWSJPWyzYbiF8YGfAIrZcTHo2Rw6iEDbdtbQ8Y9YBFviXKver4LJunF9elKaCWc
	 pa2Om15Jdy65g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Tao Liu <ltao@redhat.com>,  linux-riscv@lists.infradead.org,
  kexec@lists.infradead.org,  linux-integrity@vger.kernel.org,  Albert Ou
 <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Paul Walmsley <pjw@kernel.org>,
  kernel-janitors@vger.kernel.org,  LKML <linux-kernel@vger.kernel.org>,
  Baoquan He <bhe@redhat.com>,  Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,  Eric Snowberg <eric.snowberg@oracle.com>,
  Jarkko Sakkinen <jarkko@kernel.org>,  Mimi Zohar <zohar@linux.ibm.com>,
  Nutty Liu <nutty.liu@hotmail.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v4] riscv: Prevent NULL pointer dereference in
 machine_kexec_prepare
In-Reply-To: <5df82d42-89cd-4e39-95a9-a0f164c0ac58@web.de> (Markus Elfring's
	message of "Fri, 3 Jul 2026 16:38:09 +0200")
References: <20260703111530.91285-2-ltao@redhat.com>
	<5df82d42-89cd-4e39-95a9-a0f164c0ac58@web.de>
Date: Fri, 03 Jul 2026 16:59:48 +0200
Message-ID: <2vxzqzlkf7a3.fsf@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:ltao@redhat.com,m:linux-riscv@lists.infradead.org,m:kexec@lists.infradead.org,m:linux-integrity@vger.kernel.org,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:palmer@dabbelt.com,m:pjw@kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bhe@redhat.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jarkko@kernel.org,m:zohar@linux.ibm.com,m:nutty.liu@hotmail.com,m:pratyush@kernel.org,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[web.de];
	TAGGED_FROM(0.00)[bounces-9883-lists,linux-integrity=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pratyush@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,lists.infradead.org,vger.kernel.org,eecs.berkeley.edu,ghiti.fr,dabbelt.com,kernel.org,gmail.com,oracle.com,linux.ibm.com,hotmail.com,huawei.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B202703B13

On Fri, Jul 03 2026, Markus Elfring wrote:

>> A NULL pointer dereference issue is noticed in riscv's machine_kexec_pre=
pare(),
>> where image->segment[i].buf might be NULL and copied unchecked.
> =E2=80=A6
>
> Would it be helpful to append parentheses to a function name also in the =
summary phrase?
>
> Why was such a hint not be taken into account from a previous suggestion?

Oh come on, this is a really really minor nitpick. The fact that
machine_kexec_prepare is a function is fairly obvious when reading the
patch. In fact, the first sentence of the commit message uses the
parentheses.

So yes, it would have been nice to have them in the subject. But no,
this is not at all worth anyone's time to fix. Certainly not at all
worth a v5.

Please, let's not nitpick our contributors into giving up.

--=20
Regards,
Pratyush Yadav

