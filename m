Return-Path: <linux-integrity+bounces-9014-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKJuEIXpuml0dAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9014-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Mar 2026 19:05:57 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29F2C0F14
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Mar 2026 19:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A46D32EBBEA
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Mar 2026 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838203093AE;
	Wed, 18 Mar 2026 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEKx2bEE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE327E04C
	for <linux-integrity@vger.kernel.org>; Wed, 18 Mar 2026 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855384; cv=pass; b=mCt46eh6zUcWhLJag6KLCWuNWYjcV4qSQ0PTRTln7vUOCZ3C4AbVfXWwnVMU4MYQ5pO+09MEC8NqWaH5ZR8xJMKUgrbKuGx/Ip1VK206d/aFIB03Vf8/IKYRfxzHxqsAmwlMeiCDs6f4Q2pcyUu/F9/rtSwjpnO6u0/jDyjfn90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855384; c=relaxed/simple;
	bh=ETQ6eDY+SrtspdH+SID48Rk/pkOlNOXeML+vzVx/MB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWQiGASOaS691YPtjD0c1LgZ4Eyuhqr6Dk408eqonjfGH38j3xn2qGRvKe4VftX38aKRmenK7L8ibitVqvlnxYtk8z7nv2lNMIRny5J55svYq84P3VFE+kBHvL5wcwe6nCTJY/9pI2F0FZIoHvBbx+kFjoGktlPVXlPTJIzHZSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEKx2bEE; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1271195d2a7so393630c88.0
        for <linux-integrity@vger.kernel.org>; Wed, 18 Mar 2026 10:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773855382; cv=none;
        d=google.com; s=arc-20240605;
        b=cMRrBjo4AaznWe7mEa9SQLT8FwZ6P/ua/nqy451H/+lMTEsD6QZODBdsrCvfOGDkY3
         iRiEFzVHWb1em9KpIh6fruzmGvQZLUyNorQ30ntPl1nmDRWEvTLxi1Kd8qIHENDBeCJM
         eHFN1dYcl1nbS0WX4mj7TWnRitxFXB7CDi0EXwvx8TvhWYKMX8JiX4tVu2k7n77RMMVT
         vsZOydOlTsCz4nubyNaIz0Mhuxzx+LXI+AQnElHjAoRd5br3Z+YeHrMgMdr1REFYZeEF
         Yu+uCq/RYrW10WN3YWiWISW7WSn5iy2RCG5UWfJ4YnX90uNUTjkdzg8bF1vl8ui1sgPL
         d53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CBZBsMC1tuLlkRKALQZa43xF7bjMBt9AHLZN8Ng7/jM=;
        fh=n8Jyam8OTJqO7Dfo3WuNB1FbTcIuW5aYDUGcXjKT8WI=;
        b=GldklxVRLocozoFUVN3usX0QTMyeP2DZS49W3id5fjt/Rjl7CmST97iWLZKg1YD/Di
         qo4wUZ+1ShGBGoZtwgv6M8vQlWuSBPUkQLRDhGnbD6LVXEO1TOamFd3zwazv68Vr1e0g
         0E/PAqtxzA07TisXbJczdcQWlg32Hrwg7moqXpoYCWa2FwkK33LdSYcNSSVj049tVmtv
         lj+VNhZnRLFw6xiUzjMZ9veANs15V7qkP06Q6UPzAWZDzxkLT8Z+qCsiBxvmVU9jQDkZ
         djRuMw3TTBAI3WjDssshF7poJWMIg+/DucD+20TxnllytOOvVohCzurzjCyd/Wv9M+5B
         uhhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773855382; x=1774460182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBZBsMC1tuLlkRKALQZa43xF7bjMBt9AHLZN8Ng7/jM=;
        b=AEKx2bEERz2f7/KhHE67goH75bm9Og/0PVyvWwlEceqQjFBei7zXZoBUWdUkoXEANx
         DR69Zal/tu31gALsnZSo/ZhVQNYDObJZYIrEtOhrRRBs3tJ4nlQ6oOMJFsIOnyZ6RQdc
         1KsGem0V/nyu45S9KijOPLujW5iOxOSXg+hCsrk9TT+q8drCb7OHSRhJzFeOd9Bb1GAO
         RVbkFi9+3HoA+dFpQNDpJa3Zp1lEK4X2ZtgcERoc6QZiVrtrVTym8PO1PBgO3hBWvOtG
         D1J7cXk0DH6mQrMS/PWC5/Pb77RM27ULnDEd+TWcEZmTFZtzK+IPM0yIL2cqN6JiG2Ch
         yZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855382; x=1774460182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBZBsMC1tuLlkRKALQZa43xF7bjMBt9AHLZN8Ng7/jM=;
        b=lnNyUu2mIs0yz7WmrEVpOUB5GrN1Orx5SMUftj6cpY6nAx/N42VpXVQ4pODU0tEQ+e
         R+ARcaJPh0lKRLstcd/cORvQb/0xHJQe51kvbqLvy4ME8397EZ1jEeDEnYubyF5EykE+
         OEFW3n+NKzkH/JITRkwadcVJvavPhxffbgYzFN2sOvwXsS52vPtZ9vgFNnVVfqjCyqZz
         Qxek/RVm7W1UnGWd7dvPF0I6f2pYF6i/vAxoib4nQaPUu3hYl6Mdot2LnsAYWUcKqKhk
         k/MRadQVJgKRhIP95mGijDD8uNQJHq5p63sLxhmm9ebBPOqSNPde3Jtax6ysKYDYC3dL
         X2EA==
X-Forwarded-Encrypted: i=1; AJvYcCUILyWgQJ24E9xJQuJQz5Kqnj3YPFLtKv6SurcEIupeyLMI9SaF3FsoJGDELGbBg//BBNZMWb6rSl3htiaeLqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05zzbzgYO2nlXrEjNS9cdqOh5VHPeYGCPOzGSPTXb2umT9kZP
	PKI+1kmgoURwkcOHepq0UoNdTMYc8cvODWkw06KiZGR8uVX5iJk81y1RwpnJb7e4Nxy24ulhduq
	u1Gpv+mOd/Ukr2BfOuVvDKuUits2/dEyO7C/QueSx
X-Gm-Gg: ATEYQzwBAfizQPkSC+VABfc4Or4Ge7iU2IYJIDQ1jR73A21+eCJADD2eaO1c+fCeDMO
	36vKgCLffhaTpXZSD6wqc4eZMqqftTpCx8q0/FJdGwdewt8fsnP4Gb+HXz+m6LdguQay6R6nYrY
	cXosf1tmO1QjHlBQfZ8Pi9Wg0g+pxvsaKlLTe8vhgckp1fn/zWg8bGVysBOJd0PLuRVcyslrKg3
	BFosXK/cjWdP1QjVedDLu+UfTVERpAiU3WNBFdTiaoaTOMYDzziif7Q7y81HzDVbP4895UPlxm/
	RPNwaA==
X-Received: by 2002:a05:7022:102:b0:128:e2a9:d97b with SMTP id
 a92af1059eb24-129a71c3221mr2167012c88.42.1773855381476; Wed, 18 Mar 2026
 10:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125192526.782202-1-jarkko@kernel.org> <20260125192526.782202-2-jarkko@kernel.org>
 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
 <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
 <aadTgsbzDDkCg1Pr@kernel.org> <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
In-Reply-To: <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
From: Chris Fenner <cfenn@google.com>
Date: Wed, 18 Mar 2026 10:36:09 -0700
X-Gm-Features: AaiRm53CRvkQ4Q080Fnyv4js1FR3nt9n7ROPC-ZktGzrj5RdGkL16HIOocsid-Q
Message-ID: <CAMigqh2kW_srDgnOs+1t=sk9Q9jJgaQVswO0ZRHhV-6zrOAZ6A@mail.gmail.com>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	Jonathan McDowell <noodles@earth.li>, Eric Biggers <ebiggers@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9014-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfenn@google.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dlp.rip:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DB29F2C0F14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apologies if my long message derailed this discussion. I meant to
support Mimi's concern here and project a future vision where
TCG_TPM2_HMAC doesn't conflict with other features.

More concisely, I think that:

> tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled

is not a compelling argument for removing TPM as an RNG source,
because TCG_TPM2_HMAC is known to have poor performance already
anyway.

Thanks
Chris


On Thu, Mar 5, 2026 at 7:37=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
>
> On Tue, 2026-03-03 at 23:32 +0200, Jarkko Sakkinen wrote:
> > On Fri, Feb 20, 2026 at 10:30:26AM -0800, Chris Fenner wrote:
> > > My conclusion about TCG_TPM2_HMAC after [1] and [2] was that
> > > TPM2_TCG_HMAC doesn't (or didn't at the time) actually solve the
> > > threat model it claims to (active interposer adversaries), while
> > > dramatically increasing the cost of many kernel TPM activities beyond
> > > the amount that would have been required to just solve for
> > > passive/bus-sniffer interposer adversaries. The added symmetric crypt=
o
> > > required to secure a TPM transaction is almost not noticeable; the bi=
g
> > > performance problem is the re-bootstrapping of the session with ECDH
> > > for every command.
> > >
> > > My primary concern at that time was, essentially, that TCG_TPM2_HMAC
> > > punts on checking that the key that was used to secure the session wa=
s
> > > actually resident in a real TPM and not just an interposer adversary.
> > > I wrote up my understanding at
> > > https://www.dlp.rip/decorative-cryptography, for anyone who wants a
> > > long-form opinionated take :).
> > >
> > > Unless I'm wrong, or TCG_TPM2_HMAC has changed dramatically since
> > > August, I don't think "TPM2_TCG_HMAC makes this too costly" is a
> > > compelling reason to make a security decision. (There could be other
> > > reasons to make choices about whether to use the TPM as a source of
> > > randomness in the kernel! This just isn't one IMHO.)
> > >
> > > The version of TCG_TPM2_HMAC that I'd like to see someday would be on=
e
> > > that fully admits that its threat model is only passive interposers,
> > > and sets up one session upon startup and ContextSaves/ContextLoads it
> > > back into the TPM as needed in order to secure parameter encryption
> > > for e.g., GetRandom() and Unseal() calls.
> >
> > Neither agreeing nor disagreeing but this patch set clearly does not
> > move forward and I spent already enough energy for this. For better
> > ideas the patches are available in queue branch.
>
> Jarkko, you totally ignored my comments below.  I object to your removing=
 the
> TPM trusted-keys RNG support.
>
> Mimi
>
> >
> > High-level takes don't move anything forward (or backward), sorry.
> >
> > >
> > > [1]: https://lore.kernel.org/linux-integrity/CAMigqh2nwuRRxaLyOJ+QaTJ=
+XGmkQj=3DrMj5K9GP1bCcXp2OsBQ@mail.gmail.com/
> > > [2]: https://lore.kernel.org/linux-integrity/20250825203223.629515-1-=
jarkko@kernel.org/
> > >
> > > Thanks
> > > Chris
> > >
> > > On Fri, Feb 20, 2026 at 10:04=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.=
com> wrote:
> > > >
> > > > [Cc: Chris Fenner, Jonathan McDowell, Roberto]
> > > >
> > > > On Sun, 2026-01-25 at 21:25 +0200, Jarkko Sakkinen wrote:
> > > > > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and =
thus its
> > > > >    use should be pooled rather than directly used. This both redu=
ces
> > > > >    latency and improves its predictability.
> > > >
> > > > If the concern is the latency of encrypting the bus session, please=
 remember
> > > > that:
> > > >
> > > > - Not all environments expose the TPM bus to sniffing.
> > > > - The current TPM trusted keys design is based on TPM RNG, but alre=
ady allows it
> > > > to be replaced with the kernel RNG via the "trusted_rng=3Dkernel" b=
oot command
> > > > line option.
> > > > - The proposed patch removes that possibility for no reason.
> > > >
> > > > Mimi & Elaine
> > > >
> > > >
> >
> > BR, Jarkko

