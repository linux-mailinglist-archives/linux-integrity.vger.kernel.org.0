Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B56D833B
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 00:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbfJOWF3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 18:05:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58476 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfJOWF3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 18:05:29 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2139B20B71C6;
        Tue, 15 Oct 2019 15:05:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2139B20B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571177128;
        bh=4LKmqfOFNI45iExJsvp77DTwZ1f6bFrEwErCUVGHtcs=;
        h=From:To:Cc:Subject:Date:From;
        b=oGFvSmryVeV9jG1LJgb0IcGo9I3OsGgugTg65w35dVDvH3OnsYkTtzzGzF3nEk87c
         SFaZ/4GGpLN8K1+Zm8AbmbAlDbfd+iWrEGn7TBJNJ5/ysiheWkaXskQfwrSvjskRkt
         jVY7DludaXNajwk+WuT7VN4w49pO9ztg0VZVL0XI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, prsriva@linux.microsoft.com
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v0 0/1] ima: Refactor process_buffer_measurement() to make it generic
Date:   Tue, 15 Oct 2019 15:05:23 -0700
Message-Id: <20191015220524.20659-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch makes the function process_buffer_measurement() generic so that
it can be used to measure more than just the KEXEC_CMDLINE. This function
will also be used for measuring keys, blacklisted binaries, etc.

Lakshmi Ramasubramanian (1):
  ima: Refactor process_buffer_measurement() to make it generic

 security/integrity/ima/ima.h      |  3 +++
 security/integrity/ima/ima_main.c | 29 ++++++++++++++---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

-- 
2.17.1
