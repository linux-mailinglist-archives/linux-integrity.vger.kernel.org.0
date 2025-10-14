Return-Path: <linux-integrity+bounces-7432-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEF0BDAAB5
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Oct 2025 18:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F7104FC098
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Oct 2025 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C893002C2;
	Tue, 14 Oct 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMSWJVzO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62C2D876F;
	Tue, 14 Oct 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460148; cv=none; b=DY+gU32gqTAoaIlcsDeDi1uKSvuZzBro50kuOHP3bBbRwmkvOIhlDUcfughWUoX3iHV8JyqKOvt1NiRQNCQm+mCHGU7l/n8s1LAG4H+nq6HvyPw0EXj6UUwkyPTkUC64D37PlTGcb+D6+vJRqnndI65Wbj1uQz860lDpYl4N52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460148; c=relaxed/simple;
	bh=kzUoUpAM8ISIy11Qj+JGayB53mZL25D9BT56N08xfig=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UCirKAuUo3a3/eztkmLUHjzQfTt4NRWao+IlZcyLNg91OCq/jWc+0dwAj1qMa5nHaos26uzdi26rkberX9jdPO8pxGhGIWrWOwM1FNn1JkaBHEHld/WLF6yGwSwJ5uoWo1C+xWXnwVJlnX76ouOZT/mak0of6Z9s/AvQ1vgQcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMSWJVzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440A5C4CEF9;
	Tue, 14 Oct 2025 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760460147;
	bh=kzUoUpAM8ISIy11Qj+JGayB53mZL25D9BT56N08xfig=;
	h=Date:From:To:Subject:From;
	b=rMSWJVzO50i/2rZuw0KRvhLXjfS1AEg2HoSTA4Qf09Fkn06HWbyhjZeRLPwLtf2iI
	 lu7eBu2ylyf9G5vsUVh8nWlsIdyLNS7hYvGf1f9ckDTSE+98KttWIFmmLa6qBp7ugI
	 i73T3EusI9HpTHvuVo96ytAfjEpzmL0RnPXNXGIDo711mtoau/daN+aaARFse3hv5Q
	 cVr/qeN3YrmOhgmPqX5L+bocQ2PxmIIcJB5EX/Xx0+b+vOB+88fRmjAMCaWGbf8jwT
	 Lxajidz1GPcEbESsoYE1fWynG/CXu8EXdo2tElr/DoeJtL7QIVRxqu9uvOJAOFprsb
	 7sPQA3f1bOMZA==
Date: Tue, 14 Oct 2025 19:42:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org
Subject: tpm2sh 0.11
Message-ID: <aO59byuIXG7fvnyf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi

Kernel testing focused and somewhat opionated TPM2 tool tpm2sh has
now first usable release:

https://crates.io/crates/tpm2sh/0.11.0

❯ tpm2sh help
Usage: tpm2sh [-d <device>] [--log-format <log-format>] [-P] <command> [<args>]

TPM 2.0 shell

Options:
  -d, --device      device path
  --log-format      log format: 'plain' or 'pretty'
  -P, --plain       print tables without headers and with space-separated
                    columns
  --help, help      display usage information

Commands:
  algorithm         Lists available algorithms supported by the chip.
  certificate       Exports an endorsement key certificate.
  convert           Converts external key files to TPMKey files.
  create            Creates secondary keys.
  create-primary    Creates a new primary key in a specified hierarchy.
  delete            Deletes TPM objects, and cached keys and sessions.
  key               Lists cached keys.
  load              Loads a key under a parent and caches its context.
  memory            Lists objects inside TPM memory.
  pcr-event         Extends a PCR with an event.
  policy            Builds an authorization policy.
  return-code       Prints a TPM return code in human-readable format.
  reset-lock        Resets the dictionary attack lockout counter.
  save              Stores a cached key to non-volatile memory.
  seal              Creates a sealed data object.
  session           Lists cached authorization sessions.
  start-session     Starts a new authorization session.
  unseal            Retrieves data from a sealed data object.

It can convert and load PKCS#1, SEC1 and PKCS#8 keys into TPMKey files,
which makes it practical with kernel interfaces.

BR, Jarkko

