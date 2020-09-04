Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4825E20D
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 21:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIDTlM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 15:41:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29271 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726994AbgIDTlL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 15:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599248470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wnpvJ71smWH2XR1UMPVlz+Lkwi5bkQ4LBjE0SpEFxVk=;
        b=F/LjNK8UUU2ylfLqB0DNK3gureHeooa2PW4j5via8vrZdsNnqZPpf1lFczqq2pPDNa2pvD
        eY/iMAS/7AyiBJrKZYn+Qlw0MDbiZEaQhFn5ZerWVA2gHGp8f/XuW9aPH3gDgLl2Og1AQh
        FmMufFKWFVsk8Ti/EHdGP4DL1t1XuK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-PYyYGR2eOhmoXhlEk4XiJw-1; Fri, 04 Sep 2020 15:41:08 -0400
X-MC-Unique: PYyYGR2eOhmoXhlEk4XiJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 539EB10BBECE;
        Fri,  4 Sep 2020 19:41:06 +0000 (UTC)
Received: from localhost (ovpn-116-173.gru2.redhat.com [10.97.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD81B7E164;
        Fri,  4 Sep 2020 19:41:02 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 0/4] integrity: improve user feedback for invalid bootparams
Date:   Fri,  4 Sep 2020 16:40:56 -0300
Message-Id: <20200904194100.761848-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some boot paramenters under integrity/ don't report any feedback to the user
in case an invalid/unknown option is passed. With this patch, try to be more
informative about what went wrong, including a more strict secure boot
feedback.

Bruno Meneguele (4):
  ima: add check for enforced appraise option
  integrity: invalid kernel parameters feedback
  ima: limit secure boot feedback scope for appraise
  integrity: prompt keyring name for unknown key request

 security/integrity/digsig_asymmetric.c | 10 ++++++++--
 security/integrity/evm/evm_main.c      |  3 +++
 security/integrity/ima/ima_appraise.c  | 27 ++++++++++++++++++--------
 security/integrity/ima/ima_main.c      | 13 +++++++++----
 security/integrity/ima/ima_policy.c    |  2 ++
 5 files changed, 41 insertions(+), 14 deletions(-)

-- 
2.26.2

