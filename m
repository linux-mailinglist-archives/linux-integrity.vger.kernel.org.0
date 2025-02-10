Return-Path: <linux-integrity+bounces-4764-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B29A2F2E2
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 17:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C851D1889D2F
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE01F4612;
	Mon, 10 Feb 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="WNJFpbbY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A841F460E
	for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204034; cv=none; b=g5hBBLUSp1LSR1EcoS2q+WOBQrtKzqObmerwS1bVeU0bWRJ6Kjw3bOnw9QPqqWpSglCFrcmb9a6YkNxdtaFv4GLv9M6ra82sW+6bmYNOuN6RPcraxtWHUtiJuiWOlnXrIhVkCqtBvnmMybk5y1vJrRRwj8CVbLoJOCkbfptf5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204034; c=relaxed/simple;
	bh=NQEenHjhF51u1m2K/t9YQdk7MapsbnlNPUj60+5Jn5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKgozdV7MlSDdXe3d9I60D8qBfgVCNLSX9qZPpLVp7DB5JFD/y2Zq+KqlBbrZ7V91MFoBB9idxQfpuHNT5MUEMiZR4UR1bV7yOkffrr3V3CUVHNw6tPKCPj2f7cM9SbvjCMpTy1u40LNiGy2s6VW/2EBnYFcULk6lK3H7oz8oKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=WNJFpbbY; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=q53AG8j8nGRxcN8d1Nt4p7fZmlTh1dwWoXEBbR9t3pY=; b=WNJFpbbYA1DPv8b88ljnpiR93a
	Tw1OHzVGrv9Dqs0lhSI3MgjITEJ09zJkaIdxhgntnaOBiXagcfQX/AIgVhVeIo/l7V8O+opbsvjJf
	P3UyunvPFYuCejkfkMGJo7vQsUUWTHJ3Lo46wMcUlciYhx98yCUCuXF2eAJhWlQep3JPtLN9OL5u0
	HgQdo5Lizgjf79t6S2+G/T1trRbbYZnjn1d1tcucUcgAvCMqatMFl5KGuXOOmFv8207nleTIOnllE
	C+QK+fsjCrM03TX4PwhzCMlNvjh+EFk4gWnpuYJwKyTmovg/kztvlABroCFnpzavVJbsuoNVlwHx/
	8GeQrSuA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1thWPn-001rk1-2v;
	Mon, 10 Feb 2025 16:13:43 +0000
Date: Mon, 10 Feb 2025 16:13:43 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6olt1NHonKkamtM@earth.li>
References: <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
 <Z6XRuFnEXeQI_rEZ@earth.li>
 <Z6XVAEfLIVDuwSLn@kitsune.suse.cz>
 <Z6XWoWAy66P97pAU@earth.li>
 <Z6XZN3U5nmb6qu9u@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="c4Np5EkGR3/BQLB0"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6XZN3U5nmb6qu9u@kitsune.suse.cz>


--c4Np5EkGR3/BQLB0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Feb 07, 2025 at 10:58:15AM +0100, Michal Suchánek wrote:
> On Fri, Feb 07, 2025 at 09:47:13AM +0000, Jonathan McDowell wrote:
> > On Fri, Feb 07, 2025 at 10:40:16AM +0100, Michal Suchánek wrote:
> > > On Fri, Feb 07, 2025 at 09:26:16AM +0000, Jonathan McDowell wrote:
> > > > So just to clarify, this more recent patch is working around a situation
> > > > where the status register gets stuck and needs a complete retry of the
> > > > command send - it's an Infineon errata, not something that would be
> > > > fixed with a longer timeout.
> > > > 
> > > > We see what looks like Michal's issue with timeouts as well, I just
> > > > haven't made the step of instrumenting it all the way he has.
> > > 
> > > And I haven't seen the issue that needs re-sending the command so far.
> > 
> > Your SLB9672 is on the latest firmware, which I believe fixes the
> > problem.
> > 
> > > Maybe it happens even less frequently than the excessive processing
> > > time.
> > > 
> > > Fully restarting the syscall would fix both issues but manual restart of
> > > the userspace task reportedly did not work so I have my doubts that
> > > this method with returning from the syscall would be effective.
> > 
> > Hmmm. I wonder if e3aaebcbb7c6b403416f442d1de70d437ce313a7 (tpm: Clean
> > up TPM space after command failure) would help the userspace restart
> 
> It's backported to the frankenkernel already so it would not help this
> particular case.
> 
> Unfortunately, it's not clear what the userspace task does, and why it
> would not complete after the first failure.
> 
> Would need to come up with some way of tracing it.

FWIW bpftrace is great for this. I'm using the attached script as a
basis for investigations. Obviously the timings it reports are the whole
command rather than just the wait for status, but over a long period it
can then show you the latency histogram. (Run it in one terminal, do TPM
stuff elsewhere, hit Ctrl-C when you're done and it dumps the
histogram.)

J.

-- 
101 things you can't have too much of : 47 - More coffee.

--c4Np5EkGR3/BQLB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tpm-tracing.bt"

#!/usr/bin/bpftrace

struct tpm_header {
        uint8_t tag[2];
        uint8_t length[4];
        uint8_t ordinal[4];
}
struct tpm_buf {
        uint32_t flags;
        uint32_t length;
        struct tpm_header *hdr;
}

kprobe:tpm_transmit_cmd
{
        $buf = (struct tpm_buf *) arg1;
        printf("%s (0x%02X%02X%02X%02X) (%s)\n", comm,
                $buf->hdr->ordinal[0],
                $buf->hdr->ordinal[1],
                $buf->hdr->ordinal[2],
                $buf->hdr->ordinal[3],
                str(arg3));
}

kprobe:tpm_transmit
{
        $hdr = (struct tpm_header *) arg1;
        $cmd = $hdr->ordinal[0] << 24 | $hdr->ordinal[1] << 16 |
                $hdr->ordinal[2] << 8 | $hdr->ordinal[3];
        @start[tid] = nsecs;
        @tpmcmd[tid] = $cmd;
}

kretprobe:tpm_transmit
/@start[tid]/ {
        $dur = nsecs - @start[tid];
        @cmdhist[@tpmcmd[tid]] = hist($dur);
        printf("%s (0x%08X): %d (%d ns)\n", comm, @tpmcmd[tid], retval, $dur);
        delete(@start[tid]);
        delete(@tpmcmd[tid]);
}

--c4Np5EkGR3/BQLB0--

