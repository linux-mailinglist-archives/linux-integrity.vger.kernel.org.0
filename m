Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEA247928
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 23:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHQVwn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 17:52:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38916 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728684AbgHQVwm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 17:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597701161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W6Jm32pmHzVG6BIYQ5uMSES04XsfjnL/gJNJzBMhUM8=;
        b=i2epg6aP3niFv9NWM+9k6GaYgKa4JFs+kGSP/ptzElQ0zSD5q1LEWFCstaRMss/dx7gBt7
        qjujx6v9TCHZDV7HOWXxibQ50FZxFiaKvP+Py16XAP4ByYS+J1AxLfsGVORQwFQi/nzuM8
        uWEEp6jGK65ievx5hqOKDuJlfFrDjXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-NHSLYPqENguRL4TJqN7yXQ-1; Mon, 17 Aug 2020 17:52:39 -0400
X-MC-Unique: NHSLYPqENguRL4TJqN7yXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E61531007B00;
        Mon, 17 Aug 2020 21:52:38 +0000 (UTC)
Received: from localhost (ovpn-116-138.gru2.redhat.com [10.97.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A1B85C645;
        Mon, 17 Aug 2020 21:52:35 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 0/4] integrity: improve user feedback for invalid bootparams
Date:   Mon, 17 Aug 2020 18:52:29 -0300
Message-Id: <20200817215233.95319-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
  ima: limit secure boot feedback scope on appraise bootparam
  integrity: prompt keyring name for unknown key request

 security/integrity/digsig_asymmetric.c | 10 ++++++++--
 security/integrity/evm/evm_main.c      |  3 +++
 security/integrity/ima/ima_appraise.c  | 20 +++++++++++++++-----
 security/integrity/ima/ima_main.c      | 13 +++++++++----
 security/integrity/ima/ima_policy.c    |  2 ++
 5 files changed, 37 insertions(+), 11 deletions(-)

-- 
2.26.2

