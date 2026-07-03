Return-Path: <linux-integrity+bounces-9882-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K+i2J4/MR2r7fQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9882-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 16:51:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD3C7039E1
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 16:51:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=FnsWbW47;
	dmarc=pass (policy=quarantine) header.from=web.de;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9882-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9882-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D1B230574A7
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jul 2026 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57263DB31D;
	Fri,  3 Jul 2026 14:43:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AB21CC59;
	Fri,  3 Jul 2026 14:43:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089819; cv=none; b=BBnCd2i5lgMixltHBmRSGCblcdJpFOspdPzpuDQ0/LAC1g0CQZG5mrBQHL8njCP57HxFVPReiz7L6HAgmhsLAyY98tjMbIzQamuN+4aKqu/zP3pbSUfEHoykGRo7yIZpzIlQzilkU5BhCzJWAJ22XJ1wauGpmct1lhKzSF7lWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089819; c=relaxed/simple;
	bh=EB2g52ML9w7Ti0I5lh6WIZuElr5+ILDxpx38iWGZDv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RffX3ga1sqi+9u2ccJKL4SPjKTLt8EMPEPjkitQg1upSuPMAJwLU/vpD/YZEIuPPD/fFOwORL6Vp2t0sjWTJ9eTzbZKfTSEaY4lyB4oIj15LH/gZIl5ExenFuv/18AiUCVpTy69ES9+m1C9S8AcQ1yvN5UCjBNzfFW7l3jtxhCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FnsWbW47; arc=none smtp.client-ip=212.227.17.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783089494; x=1783694294; i=markus.elfring@web.de;
	bh=EB2g52ML9w7Ti0I5lh6WIZuElr5+ILDxpx38iWGZDv0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FnsWbW47FjvALC7zgV3+0fiQShsfqWGiz7rlBDL1wFFlt9DbWhtxOFoyTM3/EoxO
	 Vf6v9Hc8zomuc4aCIUDssZ9a70iVFomO8YecCugNAriVqw4mpf3jg6bbR6QHQn1JX
	 DHLB5ToKyi+SrfsCYpIAsvCycS++rMOJQ9eYW84cny7ETZ9ivMi6HKiLkluxm6g02
	 /h4MfCVaH2oNihYnffWdg1kHVug9SWdZTjjkdRLQNW/qzDCAD0qezYz3rs3g2ih/3
	 af8sr8Z4nhWwpDlJH6QalwlfSJvcXpZbu4vmq0BN8ZHQo38N8alz4tysSM+hCjIm/
	 ciYloj0Sir8jJCt6YA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrOhx-1xQ3L03Q9v-00mp6N; Fri, 03
 Jul 2026 16:38:13 +0200
Message-ID: <5df82d42-89cd-4e39-95a9-a0f164c0ac58@web.de>
Date: Fri, 3 Jul 2026 16:38:09 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] riscv: Prevent NULL pointer dereference in
 machine_kexec_prepare
To: Tao Liu <ltao@redhat.com>, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Baoquan He <bhe@redhat.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Pratyush Yadav <pratyush@kernel.org>,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20260703111530.91285-2-ltao@redhat.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260703111530.91285-2-ltao@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:flxU61AON1tOB/5zV1NWRLFjDo9z4XR+iONMuTkfID4WUXbAAHJ
 wjej4JJ56IcMz11JLo9GZw+YeFpRTaaljw4W1aAOLsTLlVHhZT6fqDngl/wbRFNYyC1QIDb
 d/WO0NR4AXZlGiBOky1skJXNAnZvsipnUKOXPXJAehMbxawkDgQS7fk9uxQoZt0oTm9NfX2
 43/fgfxHWasbteYethxhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+MRkKKiSlJk=;Xlp2E5WYTtay1kxrKMBxgI0g//r
 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
 04Frq2IItzwMQh+oTs=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9882-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ltao@redhat.com,m:linux-riscv@lists.infradead.org,m:kexec@lists.infradead.org,m:linux-integrity@vger.kernel.org,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:palmer@dabbelt.com,m:pjw@kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bhe@redhat.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jarkko@kernel.org,m:zohar@linux.ibm.com,m:nutty.liu@hotmail.com,m:pratyush@kernel.org,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,oracle.com,kernel.org,linux.ibm.com,hotmail.com,huawei.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CD3C7039E1

> A NULL pointer dereference issue is noticed in riscv's machine_kexec_pre=
pare(),
> where image->segment[i].buf might be NULL and copied unchecked.
=E2=80=A6

Would it be helpful to append parentheses to a function name also in the s=
ummary phrase?

Why was such a hint not be taken into account from a previous suggestion?

Regards,
Markus

