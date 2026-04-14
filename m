Return-Path: <linux-integrity+bounces-9180-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I7rNcd13mkqEgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9180-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 19:13:43 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BFE3FCE86
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BC2430211E3
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5552F5491;
	Tue, 14 Apr 2026 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apAEUvbs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA252DA75C;
	Tue, 14 Apr 2026 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186771; cv=none; b=cbGU/aRe9a+g5mTs4w3QmJgYbyEzsKCfuNumyPIZfVczZZiUOYuDzR1rtgeh0QWwWXbfUjIAev9qCp+p6XHUVKSbNFkaEycScA4GR4BzMaoz5UWXbcpPLCCxCAjchc2sNNm/UCrqaD190d0Az10dIk7+QSJc7r9CceGjUUXheG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186771; c=relaxed/simple;
	bh=0X+z1KsWPE0A4r+mFYL/EnGvhzEsdG3SgGgaDKXaP6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baD1sZk3g0OX5RFRyG97s55+77g4R64HonRNu4Z47cVO9E/q+YLdxPIYgKPGV1VmAjeDgrOrTQfeoa0SdQdiWrtX3FJXWUoPG4gm77VSf8ubu5KnFe97b+g/fguNwECTKsIkkmjfTc4MVI/pNbqZQlTFVyD3YRN3QEZ+NR/OJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apAEUvbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBC5C19425;
	Tue, 14 Apr 2026 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186771;
	bh=0X+z1KsWPE0A4r+mFYL/EnGvhzEsdG3SgGgaDKXaP6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apAEUvbsP2z9PGHZo435AvIpig1yQHgjeHaWtXFlrLTR+0MDU+V4wdMvg6q1DcIE0
	 JP1yfdxibcauj5rlansQ5CeCJ9Lfhgn/8v87d5R0GyX9XJtU2XCh2Wa+r0opu8vIsM
	 8UT1PKRVcAZKpieAtz3R9oPBqUG7o4Ho8n41K3QxFhcLkezjXP0vUb8u1gGg/8rjoF
	 hodxKE3ehM3/7noswhBBdgQy7mUjsqiNsK5vbZh6z2+RHaP4gQa9xLgiiqgR9uUPDr
	 G/zJlJWcFucNtA50nZSQ6xo4XsOkdwnyAkdFyfFjIjBD1mXahHW4Jyn4D2VVOGyhX0
	 yZX8B5MmY+S7w==
Date: Tue, 14 Apr 2026 13:12:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [RFC PATCH 00/10] Fix dm-ima bugs
Message-ID: <ad51kuxJuU84Amep@kernel.org>
References: <20260414002244.1917447-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414002244.1917447-1-bmarzins@redhat.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-9180-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59BFE3FCE86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 08:22:34PM -0400, Benjamin Marzinski wrote:
> The dm-ima code does not guarantee that the dm_ima_measure_on_*
> functions will not be called at the same time. Since they modify and
> free shared memory, this can lead to Use-After-Free errors or garbage
> measurements. Further, they don't make sure that the state they measure
> corresponds to the actual device state. For instance if table_load()
> runs at the same time as do_resume() on a table swap,
> dm_ima_measure_on_device_resume() can end up thinking the wrong table is
> active. Or a concurrent dm_hash_rename() and a table swap, can end up
> with a the new active table still using the old name. This patchset
> makes sure the the dm-ima function are serialized and report the correct
> device state.
> 
> However, the code is still messier that in could be. This is because
> it duplicates the current measurement events and format. I would really
> like to know if that is necessary. Specifically, it currently measures
> the following dm device and table actions:
> 
> load
> clear
> rename
> resume
> remove
> 
> I don't see the benefit of reporting changes to the inactive table, or
> resumes where the device does not change state. From the user's point of
> view, the device is still the same after these events.  At the same
> time, it doesn't measure device creates if no table was loaded, so you
> can have situations where the the first measurement for a device is a
> rename or a remove. A more sensible set of actions to measure would be:
> 
> create
> table_swap
> rename
> remove
> 
> Also, the measurement format doesn't map well to how dm device's are
> actually set up, in a way that makes it harder for the code and records
> extraneous information. First, like I mentioned before, I don't see the
> benefit of measuring the inactive table. Second, the name, uuid, and
> major/minor numbers are properties of the device, not it's table (and dm
> devices can't have partitions, so the minor count will always be 1). I
> don't see a reason to store and occasinally log this information twice,
> if there is an active and incative table, and it forces extra
> coordination between the dm_ima_measure_on_* functions.
> 
> I'm wondering it we are stuck with the current events and format, now
> that this has been released? Or could we bump the version, and change
> what events we measure, and how we format the output?
> 
> Benjamin Marzinski (10):
>   dm-ima: remove dm_ima_reset_data()
>   dm-ima: remove broken last_target_measured logic
>   dm-ima: Remove status_flags from dm_ima_measure_on_table_load()
>   dm-ima: don't copy the active table to the inactive table
>   dm-ima: Fix UAF errors and measuring incorrect context
>   dm-ima: remove new_map from dm_ima_measure_on_device_clear
>   dm-ima: Fix issues with dm_ima_measure_on_device_rename
>   dm-ima: Handle race between rename and table swap
>   dm-ima: Fail more gracefully in dm_ima_measure_on_*
>   dm-ima: use active table's size if available
> 
>  drivers/md/dm-ima.c   | 506 +++++++++++++++++++-----------------------
>  drivers/md/dm-ima.h   |  67 ++++--
>  drivers/md/dm-ioctl.c | 146 +++++++++++-
>  drivers/md/dm.c       |   2 +-
>  4 files changed, 421 insertions(+), 300 deletions(-)

Pretty extensive changes needed here all things considered.

SO I'm aware, who is using dm-ima?  I see that Tushar Sugandhi is no
longer at Microsoft and so he isn't cc'd on these changes.  I can
infer from Cc some potential users, but I just want to make sure this
code isn't just technical debt that we're having to carry in DM now?

Thanks,
Mike

