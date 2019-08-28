Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89F9F785
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 02:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfH1Aq0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 20:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfH1Aq0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 20:46:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59982308A9E2;
        Wed, 28 Aug 2019 00:46:26 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-118-116.phx2.redhat.com [10.3.118.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECAF660923;
        Wed, 28 Aug 2019 00:46:25 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 0/2 v2] tpm: add update_durations class op to allow override of chip supplied values
Date:   Tue, 27 Aug 2019 17:46:19 -0700
Message-Id: <20190828004621.29050-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 28 Aug 2019 00:46:26 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We've run into a case where a customer has an STM TPM 1.2 chip
(version 1.2.8.28) that is getting into an inconsistent state and
they end up getting tpm transmit errors.  In really old tpm code this
wasn't seen because the code that grabbed the duration values from the
chip could fail silently, and would proceed to just use default values
and move forward. More recent code though successfully gets the
duration values from the chip, and using those values this particular
chip version gets into the state seen by the customer.

The idea with this patchset is to provide a facility like the
update_timeouts operation to allow the override of chip supplied
values.

I went back and looked at the original submission thread, and updated
Alexey's patches based on Jarkko's suggestions for v2.


