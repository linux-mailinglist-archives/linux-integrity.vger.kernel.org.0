Return-Path: <linux-integrity+bounces-9156-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AELQGlNJ2WmkoAgAu9opvQ
	(envelope-from <linux-integrity+bounces-9156-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 21:02:43 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 150303DBC1B
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 21:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9943A302BDDB
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C433F599;
	Fri, 10 Apr 2026 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="f7neH2pQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D888EAC7
	for <linux-integrity@vger.kernel.org>; Fri, 10 Apr 2026 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847285; cv=pass; b=eSxENcfRPsdVc6DHvjCScZ4j0NHICG5nFDPZM7v0AAIKl3fnemVikHykqoouqsV8clzEqrcJ4YOjZwFsIH10+WYB5GpNOjDgEEaEXEMg2S+KxUqwR0B/UU0qJo6K7KmI7dnrSLfm/2nOi+mQmbnJvYkG8ID5VNcJrqQlZV20OCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847285; c=relaxed/simple;
	bh=tYn2FDmpTydYsc9LuArjq4s0KXJmwmP3jpRoSWg1gW4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=obYVk95U3DL2T/IPVzjuf9DXB2a52UHF2mw2dE6cl2daqtdHl+J4c0pRGN6EJpKyWlCOV5sSXFaVuU9I0Q7WZp3E8OoCgkYk+AIA21/sk6bcJvz6zvFrzw9mkQa2b0o1uXr+lSEYjlv4rtoxwOK/Wd5qRohjIomKkGSB08BJno0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=f7neH2pQ; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89f1e767f92so18952666d6.2
        for <linux-integrity@vger.kernel.org>; Fri, 10 Apr 2026 11:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775847282; cv=none;
        d=google.com; s=arc-20240605;
        b=BHvMe0S6GOibYJYScHMMSn2qCBC6ZeHhexaddEb2VZdQWdcdP8r0jfOMjYm68wXimU
         opvsvQgG7MrqVJot/b8z7YK0psvlFMOdOzky4w50zkBrCRshEP14+yns8wcAmqC2Jbla
         KgMT8vAplRqnIYC/IeNXXmwawdd8iBrEipNJY3Erm8e0av8yR6gfeUDdA9pgc3zeWtgm
         oJpaC57LBOWrfVAg6w42BzD/nwMDwoLkfXBmKJiQxGrPXBkOAx13iwWzf4LaPmdJdRhC
         fxRfIv24xRQL/0w7pj+wT3dtamAHR94bj2V+4Ww4sbVtoZXT08XqI6rYKgiCewKOt7RJ
         atUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tYn2FDmpTydYsc9LuArjq4s0KXJmwmP3jpRoSWg1gW4=;
        fh=9Rd6wGSk2eVj3sTlyxFo7Artva0UQQA+/ZQnfMlYxzs=;
        b=CLT/o087AUOron4TTPxT9gCxJ2xgYvoUcBO+t7INpTgg+OOjnQRFsJSJiJFB2Y4YG/
         Ec4zsqzI2Zm5FEqDRTOs/nst2/iNqESilNMTAwt+syT/3+CR/O3H6ohop7eZ21SLNgHL
         oZKuX5I3aCPVKZIBFQYHG2V0JiBEmsihMTcRSlsuE9gUEj+6sLl+W8EMZQm3zOoL/iAN
         Lnw+B+FqxFbbtZrLHC4BxCbAUY5pmDVuNVFwcTc4QvPRt/s5LPGlWU6SJldXMsG2SSUw
         NcNOK8cMFuGi6wrWGCkg/0k8XPaKXv1i9A2EjUyjMpuar6xt+OzlSUZo6D5o8eiYc3Hj
         9VZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1775847282; x=1776452082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tYn2FDmpTydYsc9LuArjq4s0KXJmwmP3jpRoSWg1gW4=;
        b=f7neH2pQogSc/xgvoVD5We/66cyL50ZLcGQugSXd6AHWtREgEzi/LtlsnxjjQ1dbvb
         YY5hQljJFvUVLnanjv3I6AsdCmj3bZV3JUNuKh0QTpdm9sRvhMPiJaZm4zOxzq1i6alC
         8xu4MZTOqTnCkIzrfRQyhkXPei151UDoLEEIIew5wMH6Da7TAObZuJr1APkf/pl1xhV8
         Np+3S2Sl/XUYob3MKnYJbkOcLpoK/e6dL0spNNrO0VlWSg1kBZq01UmvsBc1jZmCw9zd
         qJZAXLsqexsREAbZDso6u7/df8WZ/oxT+qwU/U7xFy92FyH2B8CYhMqMQObqg1Q5y+Px
         Nw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847282; x=1776452082;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYn2FDmpTydYsc9LuArjq4s0KXJmwmP3jpRoSWg1gW4=;
        b=et51JQ9YD/GdBrg9wQEzaPt0oGlNFI9eKJzlttTLmp0SM1if/sbmO1SRPQoneECm6x
         HsbtaDyX16sh5cL+ZQAserX3OpsedG2mc89vJIkft9c84s/a4WGb5ArWIkWfHbGukNSr
         43Y+dPDgRd+qu+/YKkOx23H6FeM3gJQ2JSjSDHhCPDh8VTsO6ZFVbSmq08pjS7So0XlI
         EkhLrOV5laLrY8B1f0ZHQZQahrg+vQXGeo68uxklALWLpXKqXDUX7407u3H5uuVP4FkL
         utSQWsoUXZYN3TVahNzQSpqtuI+pZOHLBdSQh5dkRxF1h5V2sYO803u13MhZm0Z3uoPO
         yFiA==
X-Gm-Message-State: AOJu0YySoIMXWfFXmh/OEacnHB3MTlp3XDdYpv/mU0HUOPxrbS2OVlhq
	LOAE9ATo3oEa2u0N3jmSWOav5Xzq927F39IxiyggYQvrnmNClYzr2RSbR6V0+eE0JhfPotc6f1P
	wFTPliWnJODtqxt0S0MCzH08oUSFL318cJLHjxz+ndOgA/rLKizotQo/1
X-Gm-Gg: AeBDiesJhO6qZT9+1OSw0f4X8TPEbdy0MbO+cASB96vlzpGbOy4qB3b/KZmHsoVHuk9
	XiLjZUnrvn7ofh5D4XZpCeLYn/kgxrLz1yD59c8Whks4FStttDb6X3T37ykWbwTX4Ccc8rzVKEx
	/lcqqK5Tsd8CcqfQwi/EyMqHtw5rxdf7aqnYxvao2PxmqZzjPS5ppeJxQ1ZeHLa8R7tRu9xZqRn
	VtT9pbKxuP/2b3fQB/vOOzqAfheKnEKCrZhJcyBJB8ypLbXtfZBcvb74zdOgjffW3hFsPI7eMuW
	rHUCM+6NLk+8U1TO90PeWQUq411WkHF9y2mHrj1R/xEVPvU3jGygOLPhEpXegyBqL9cgoII=
X-Received: by 2002:a05:6214:5d0a:b0:8a7:16f8:442a with SMTP id
 6a1803df08f44-8ac862ab6d1mr61113176d6.39.1775847282015; Fri, 10 Apr 2026
 11:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Danny Hu <dannyhu@arista.com>
Date: Fri, 10 Apr 2026 11:54:29 -0700
X-Gm-Features: AQROBzB5hbqPSwsV5PiqclAcDj5PvUMRxEaSaeU3kyE0D5AX8T8AzCJt6n0Hce4
Message-ID: <CAFn2k5C+AAp7MCCpsP+n8c_ghE-YkwQzy3d36jX9B1H3b+c9tg@mail.gmail.com>
Subject: ima: audit log emitted from ima_collect_measurement when SIGKILL
 interrupts reads from slow-read filesystems
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	Sahil Gupta <s.gupta@arista.com>, Pierre De Abreu <pierre@arista.com>, Julien Gomes <julien@arista.com>, 
	Kunal Bharathi <kbharathi@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,arista.com];
	TAGGED_FROM(0.00)[bounces-9156-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dannyhu@arista.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arista.com:dkim]
X-Rspamd-Queue-Id: 150303DBC1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When IMA appraisal/measurement is enabled for executables, an
AUDIT_INTEGRITY_DATA (type=1800) audit message is emitted from
ima_collect_measurement() if a process receives SIGKILL while reading
a file from a slow-read filesystem.

Configuration:
- IMA policy configured: measure func=BPRM_CHECK mask=MAY_EXEC
- stacked overlayfs with git binary on squashfs (compressed, read-only
filesystem on flash storage)
- Kernel version 6.12.68

Steps to reproduce:
$ echo 3 > /proc/sys/vm/drop_caches; timeout --signal=KILL 0.05s git
Killed
$ dmesg | tail -n 1
audit: type=1800 audit(1775843687.948:10): pid=14049 uid=0
auid=72198551 ses=2 op=collect_data cause=failed comm="timeout"
name="git" dev="overlay" ino=11529215046068473654 res=0 errno=0

The drop_caches evicts both the page cache (forcing squashfs to
re-read and decompress from flash on the next access) and the inode
cache (forcing IMA to re-hash). The timeout command execs git and
sends SIGKILL after 50ms.
During that window, IMA is reading the file page by page in
integrity_kernel_read. Since the page cache is cold, the squashfs read
path must decompress blocks from flash storage. This IO operation
causes the kernel to check for signals and return -EINTR. This
propagates up through integrity_kernel_rea to ima_calc_file_hash and
finally ima_collect_measurement, which logs the collect_data failure.

The log is more commonly observed during boot, when the page cache is
cold and all binaries must be read from flash for the first time. Many
services may start and stop concurrently, and any process that
receives SIGKILL while IMA is reading the file from flash for the
first time will produce this audit message.

I believe this log is spurious because the process is being killed;
therefore, an interrupted file read is the expected outcome. The audit
message in this case does not indicate any integrity violations as the
file has not been tampered with. Lastly, the log's presence can
mislead administrators or monitoring tools into believing a security
event occurred when it was only an expected process kill.

Questions for the IMA maintainers:
1. Is this the intended behavior? Should ima_collect_measurement still
emit the audit log when the failure is due to a fatal signal?
2. If not, could a potential fix be to skip the generation of the
audit log in ima_collect_measurement (result == -EINTR &&
fatal_signal_pending(current))?

Thanks,
Danny

