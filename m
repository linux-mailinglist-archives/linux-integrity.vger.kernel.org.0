Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C576F36BA20
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Apr 2021 21:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhDZTiI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Apr 2021 15:38:08 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45802 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbhDZTiI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Apr 2021 15:38:08 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 243DF72C8B0;
        Mon, 26 Apr 2021 22:37:25 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id ACEED4A47A2;
        Mon, 26 Apr 2021 22:37:23 +0300 (MSK)
Date:   Mon, 26 Apr 2021 22:37:23 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: calc_keyid_v2 producing different keyid for non-sha1 SKIDs
Message-ID: <20210426193723.rfar32ft3iptorii@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I am reported that IMA signatures where SKID is not just sha1 of the
public key (but something different, for example different hash algo,
such as Streebog) have "wrong" keyid in the signature. This is because
a) kernel extracting keyid from the cert's subjectKeyIdentifier (SKID)
x509 extension, (or if this fails it takes just serial, perhaps, we can
disregard this corner case), it never does sha1 over the public key).
But, b) evmctl, when signing, uses just private key (not even knowing
certificate where SKID should be) and calculating sha1 of public key.
Thus, keyids could mismatch each other, and it's even not easy to fix
evmctl, because there is no cert at the time of signing.

Perhaps, we should fix this somehow. For example, when signing,
introduce new option --cert, where SKID should be extracted. Does it
looks reasonable?

Vitaly,

