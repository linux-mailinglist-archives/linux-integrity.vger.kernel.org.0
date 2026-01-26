Return-Path: <linux-integrity+bounces-8321-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDztLM7Wd2mFlwEAu9opvQ
	(envelope-from <linux-integrity+bounces-8321-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 22:04:14 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1149A8D78A
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 22:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBB303014C0D
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 21:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E72DCBFD;
	Mon, 26 Jan 2026 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=namei.org header.i=@namei.org header.b="tCrDj2kh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.namei.org (namei.org [65.99.196.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAC246BCD;
	Mon, 26 Jan 2026 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.99.196.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769461438; cv=none; b=mLXzyqdNjrPfQZJwkVMN6FoWconN7TnAGNRX1bxkzvahEcnNilyKUbFkjSBVZs+dzZyXiGjdGXbvdum9kWtvzVWHaTd1Cja5/79ra9c8irGZuEZ2CEIWGo+P1LFuWC9zfyFDF38/wDd6o5G3EsqExTIoRxEenEMNycY5IYC0omE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769461438; c=relaxed/simple;
	bh=+9X8dy0e/R0XHnenBx+DTcalKbHzOTme2ldZVMQJPPw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=m/zGa2fA/Aefq8MRByWgs8iB+AqZ7N+9yIm3e7ibK75AuYNzgFAt0EiXMJdpbOjLvh8jiL/nEMPWEKVFd8U7AXYBg7muD/RT8xWbc04Kl8HENoQwaDiykpAdJNWr9XSezFg//cF7TnUYZ/W1YHesArB0DFSvznFUA6MChuO6lMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org; spf=pass smtp.mailfrom=namei.org; dkim=pass (1024-bit key) header.d=namei.org header.i=@namei.org header.b=tCrDj2kh; arc=none smtp.client-ip=65.99.196.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=namei.org
Received: from localhost (localhost [127.0.0.1])
	by mail.namei.org (Postfix) with ESMTPS id 320FA89D;
	Mon, 26 Jan 2026 20:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 320FA89D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
	t=1769461097; bh=KDsg4Xwcs1arQ7SUFIJ16Ldq0uYzZ8DDCOsGKuVRTNM=;
	h=Date:From:To:cc:Subject:From;
	b=tCrDj2khtFFDokf3bUTwaKjqCb2kNt+zpxKf9RfFgyR4eLzMcua75EyRJYpBZGh82
	 +mpEhAvtSrxBkHLwhe9wMDh11Q0EQTfqtDkidbRpsfdXtUxqp2QnsBJ2/dQwrlpux2
	 nLsjwj9AEG9pJ3IO6oUKXvW+TyZEMsHdTfQtTtGQ=
Date: Mon, 26 Jan 2026 12:58:17 -0800 (PST)
From: James Morris <jmorris@namei.org>
To: linux-security-module@vger.kernel.org
cc: Linux Security Summit Program Committee <lss-pc@lists.linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, 
    linux-integrity@vger.kernel.org, lwn@lwn.net, linux-crypto@vger.kernel.org, 
    keyrings@vger.kernel.org
Subject: [ANN] Linux Security Summit 2026 CfP
Message-ID: <4c3e8881-fc8d-a413-d3d1-be2a295de13@namei.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[namei.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[namei.org];
	TAGGED_FROM(0.00)[bounces-8321-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[namei.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmorris@namei.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:url,namei.org:mid,namei.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1149A8D78A
X-Rspamd-Action: no action

=============================================================================
                   ANNOUNCEMENT AND CALL FOR PARTICIPATION

                   LINUX SECURITY SUMMIT NORTH AMERICA 2026
                             
                                  May 21-22
                             Minneapolis, MN, USA
==============================================================================

DESCRIPTION
 
Linux Security Summit North America (LSS-NA) 2026 is a technical forum for
collaboration between Linux developers, researchers, and end-users.

Its primary aim is to foster community efforts in deeply analyzing and
solving Linux operating system security challenges, including those in the
Linux kernel.

Proposals should be submitted via:
    https://events.linuxfoundation.org/linux-security-summit-north-america/

SUGGESTED TOPICS

    * Access Control
    * Case Studies
    * Cryptography and Key Management
    * Emerging Technologies, Threats & Techniques
    * Hardware Security
    * IoT and Embedded Security
    * Integrity Policy and Enforcement
    * Open Source Supply Chain for the Linux OS
    * Security Tools
    * Security UX
    * Linux OS Hardening
    * Virtualization and Containers

DATES TO REMEMBER:

    * CFP Close: Sunday, March 15 at 11:59 PM CDT
    * CFP Notifications: Tuesday, March 31
    * Schedule Announced: Thursday, April 2
    * Event Date: Thursday, May 21 - Friday, May 22

WHO SHOULD ATTEND
 
We're seeking a diverse range of attendees and welcome participation by
people involved in Linux security development, operations, and research.
 
LSS is a unique global event that provides the opportunity to present and
discuss your work or research with key Linux security community members and
maintainers.  It's also useful for those who wish to keep up with the latest
in Linux security development and to provide input to the development
process.

MASTODON

  For event updates and announcements, follow:
    
    https://social.kernel.org/LinuxSecSummit
  
  #linuxsecuritysummit

PROGRAM COMMITTEE

  The program committee for LSS 2026 is:

    * James Morris, Microsoft
    * Serge Hallyn, Geico
    * Paul Moore, Microsoft
    * Stephen Smalley, NSA
    * Elena Reshetova, Intel
    * John Johansen, Canonical
    * Kees Cook, Google
    * Casey Schaufler
    * Mimi Zohar, IBM
    * David A. Wheeler, Linux Foundation

  The program committee may be contacted as a group via email:
    lss-pc () lists.linuxfoundation.org


