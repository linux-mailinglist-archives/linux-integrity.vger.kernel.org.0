Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7776C7A141
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 08:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfG3G02 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 02:26:28 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:37084 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbfG3G02 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 02:26:28 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0690B72CCE7;
        Tue, 30 Jul 2019 09:26:26 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E369E4A4AE7;
        Tue, 30 Jul 2019 09:26:25 +0300 (MSK)
Date:   Tue, 30 Jul 2019 09:26:25 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: ima-evm-utils: git tagging for release
Message-ID: <20190730062625.gpy2p4nff3vnm7sd@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
References: <20190729101252.iirdsz2j5bjk267f@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190729101252.iirdsz2j5bjk267f@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

It seems that you are released v1.2 of ima-evm-utils. (I did not receive
any announcement on linux-integrity.) I noticed that you are not using
annotated tags for release versions.

I suggest you use annotated tags (possible even signed) for release
versions. (You will need to delete existing v1.2 local tag if you are
going to retag it with annotated tag.)

man git-tag:

  "Annotated tags are meant for release while lightweight tags are meant
  for private or temporary object labels. For this reason, some git
  commands for naming objects (like git describe) will ignore
  lightweight tags by default."

Thanks,


