Return-Path: <linux-integrity+bounces-8478-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPWCMeXpiWmdDwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8478-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Feb 2026 15:06:29 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F071100DD
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Feb 2026 15:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2E0B30071CD
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Feb 2026 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649AD379973;
	Mon,  9 Feb 2026 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJYeldRk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D2378D8C;
	Mon,  9 Feb 2026 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645987; cv=none; b=sAHTamyL63o1JUzIH3O5daYofL7X8pKnLIFlFc4kQpXJQycRYPm/rNT9vwFDvvhcfswhss9vDE6jUQMvtBSivToRZiqcXzsYkLmUGywyBEYTrsCPOWEjh+ZEWIbWzGb+xawr3jcCaivzhmMB4KMbooXmvVFRgbPSpvu6Y7CiQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645987; c=relaxed/simple;
	bh=WYECX5SXJ228M5jBGqJxP6dlxH7z8FBmfDhplBvQyNA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VYhD8N7s4Z6v8O/mekhitWkQWZw9gEhnRmTmdp/ovnI44kJ5JYTQj7NNCbwTifxFHPA6J7IQ7Eh+S8EcZQ8nDFhSLvGWg+SU9aoWqSubkamywpojhG0xBucdYHr6MF4iwj3OvHwccpKFLlQw0NkuQ3p/eMOJIueT4X+ZoM9ao3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJYeldRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38055C116C6;
	Mon,  9 Feb 2026 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770645987;
	bh=WYECX5SXJ228M5jBGqJxP6dlxH7z8FBmfDhplBvQyNA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qJYeldRkukWFxC+GUEs5v29/m/MI/Jd5J/fqRB8DASUDo2L/UUNgiXj+QyfryUXA1
	 +zl8/9H/OX7KvgRJW4yoIjFobWVHUq2CPrKYlCd4i4vkes7P6Lvpz5WTh9ghhEa5zu
	 s4mzMLAQQusCMADYhTP0dSyKPueeDQQjMP5ROiulGyeBCsejhDqRt4pE3CsPwxGhIO
	 p2gYGfO8x+1uGuwqPwB5FAcyff+JTev4Md54lQscZRNrsOiiJw7Ko7nrBWsLVHB+HR
	 R/p+m3qqUzdclMNjVO/Z6rTtu0ONRzclHhKw8Nr199hWHKx/itatYVzK1FzJVSE3h0
	 LAMBf6idSe9Cg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1BD8AF40068;
	Mon,  9 Feb 2026 09:06:25 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 09:06:25 -0500
X-ME-Sender: <xms:4emJaTad_Wco9m3j7o3lgpax2A6VgGCE8LZeGlO9i5g2yHyEDNUiHw>
    <xme:4emJadNHkb9EKjKmR5ad65jXJKhI9WcoOxoazz_YJlip6wBxlVxBeuygzzZ21Nwrv
    KHso3jK22jchQasdrWQMQ3oh9QNVDuPbfnhAnDLDBRUXmvb2K1YWAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedtgefgheeutdeivdegiefgueeghfekhfffhfetheeggefhheeuvdegieev
    tdefudenucffohhmrghinhepthhrvghntghhsghoohhtrdhorhhgpdhkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    rhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeelqd
    effedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrhgu
    rdgtohhmpdhnsggprhgtphhtthhopeefuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepnhhivhgvughithgrsegrlhhu
    mhdrmhhithdrvgguuhdprhgtphhtthhopehluhhtohesrghmrggtrghpihhtrghlrdhnvg
    htpdhrtghpthhtohepughpshhmihhthhesrghpvghrthhushhsohhluhhtihhonhhsrdgt
    ohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomh
    dprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohep
    phgvthgvrhhhuhgvfigvsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehgoh
    hnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepthhrvghntghhsghoohht
    qdguvghvvghlsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:4emJaQzUmyPR98OS0DVfVCBs7nP2yOprhVntmSFyFqqjCmSR2Op5vA>
    <xmx:4emJaYjdE9_HEUdD0T7A9LUZNY5kj5IvupGKg9KTA8aXMCOAi4HI0Q>
    <xmx:4emJafQ6xQcu41rnAo5XeQjx4pSSvTX8JVKYhyLWPcyn_t6QftTgKQ>
    <xmx:4emJadPScFbmSVydk2_hRmtKQrY0ItBJpYwS2Vv8kIokJLoMdP3xtA>
    <xmx:4emJacGg1Yqc0Zi7oImUY8WRMQf-r0h2LVcpe4s-75BQFRJhA66uOmpp>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DEDB1700065; Mon,  9 Feb 2026 09:06:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAnEvm6syrbF
Date: Mon, 09 Feb 2026 15:04:36 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, "Thomas Gleixner" <tglx@linutronix.de>,
 mingo@redhat.com, bp@alien8.de, "H . Peter Anvin" <hpa@zytor.com>,
 dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
Message-Id: <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8478-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,kernel.org,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 67F071100DD
X-Rspamd-Action: no action

On Tue, 16 Dec 2025, at 00:32, Ross Philipson wrote:
> Secure Launch is a vendor-neutral approach to implementing TGC Dynamic
> Root of Trust (DRTM) support in the kernel. This is complementary to
> better known Static Root of Trust (SRTM) schemes such as UEFI SecureBoot.
>
> This series provides the common infrastructure along with Intel TXT
> support, without needing the tboot exokernel. Support for AMD SKINIT is
> pending the common infrastructure getting nailed down, and ARM are
> looking to build on it too.
>
> Originally, tboot were approached to see if they'd take support for
> other vendors, but they elected not to. Hence this approach instead.
>
> Work is being coordinated by the Trenchboot project, 
> https://trenchboot.org/,
> organising Secure Launch support for upstream open source projects 
> including
> Grub, iPXE and Xen. The goal of the Trenchboot project is to make DTRM 
> easy
> to use.  e.g. for Grub, it's simply adding "slaunch" as a command in 
> the boot
> stanza.  See 
> https://trenchboot.org/user-docs/QUICKSTART/#linux-quick-start-guide
> for more details
>
> Patch set based on commit:
> torvalds/master/fd57572253bc356330dbe5b233c2e1d8426c66fd
>
> Depends on v3 of the following TPM patch set (note this patch
> set is being actively worked on separately):
> [PATCH v3 00/10]  tpm: Decouple Trenchboot dependencies
> Message ID: 20250929194832.2913286-1-jarkko@kernel.org
>
> Finally we would like to thank everyone for their input and
> assistance. It has all been very helpful in improving the quality of
> our solution and in reviewing/strengthening our security posture.
>

Hi Daniel and Ross,

I have finally gotten around to getting the right hardware and building GRUB and Linux with your patches, and I have managed to get them running on an old Skylake HP laptop successfully.

Surprisingly, even when doing a secure launch, the EFI runtime services still work happily, which means (AIUI) that code that was excluded from the D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RTM entirely in the case some exploit is hidden in the EFI runtime code? Should we measure the contents of EfiRuntimeServicesCode regions too?

In any case, I am aware that upstreaming this work has been a painful experience so far. Unfortunately, I don't think we're quite there yet.

The way the work is divided between GRUB and Linux seems to be predicated entirely (at least originally) on the idea that the GRUB->Linux handover and the secure launch should be one and the same. I.e., GRUB sets the stage, pokes the ACM, which returns to the loaded linux image and boots it. This requires a lot of coordination, e.g., putting a MLE header in the kernel image and exposing it to GRUB in a certain manner, resource tables and other things that have to remain in sync between both sides.

There also appears to be an assumption that the fact that the ACM returns to the loaded image in 32-bit mode requires a round trip through the decompressor, which may relocate itself in memory and do other things that the slaunch code then has to work around again.

Due to the changes to the EFI boot path, this design has been watered down a bit already, in the sense that GRUB invokes the EFI entry point as usual, and only later, the pivot via the ACM is made.

Other than the SHA-1 debate [*], the main issue I have with this approach is that it adds things to the boot ABI that are closely tied to TXT on the one hand, and bzImage oddities on the other (kernel_info, setup block etc). IOW, the complete lack of abstractions is going to make this a maintenance burden going forward.

I've had a stab at implementing all of this in a manner that is more idiomatic for EFI boot:

- GRUB does minimal TXT related preparation upfront, and exposes the remaining functionality via a protocol that is attached to the loaded image by GRUB
- The SL stub is moved to the core kernel, with some startup code added to pivot to long mode
- the EFI stub executes and decompresses the kernel as usual
- if the protocol is present, the EFI stub calls it to pass the bootparams pointer, the base and size of the MLE and the header offset back to the GRUB code
- after calling ExitBootServices(), it calls another protocol method to trigger the secure launch.

The only pre-launch ABI that is being added here is a GRUB-specific protocol that is not necessarily tied to TXT. (For legacy boot, it should be feasible to call back into GRUB too, although it would be more of a ad-hoc construction, via the SLR table perhaps.) But no kernel_info and MLE headers etc being added to the ABI surface. Also, there is no longer a need for the GRUB code to understand how the decompressor is constructed, with a setup block etc, or take special care to perform PMR checks when its moves itself around in memory.

Code can be found here:

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/grub.git/log/?h=sl-v2
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-slaunch

I am aware that this is not the feedback you are waiting for at this point, given that we're at v15 already. But there are some warts in the current design that really need to be addressed before we can proceed with this IMHO.

-- 
Ard.


[*] which I still don't get: why is it fine to cap other banks with a single 0x1 byte [as the ACM does too, apparently], but do we require an SHA-1 implementation for capping the SHA-1 banks? Also, the TXT spec dropped all support for TPM1.2 so I wonder if that should be dropped from this series as well.

