Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA4808D1
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Aug 2019 03:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfHDBqE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 3 Aug 2019 21:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfHDBqE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 3 Aug 2019 21:46:04 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F253321726;
        Sun,  4 Aug 2019 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564883163;
        bh=LObcNmCTMYOwT0YqrzSQoS9DFz9YmJB/jsZ8jz9VWiw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E2bL4sYF6FreUCYUd9IpAVztcpoyip+1mUP3FEP3RYjJ24xUpPslMV+cTd2qyJ4MA
         0huAb7ZkdApN7WG1I353p1c7oZ/SscxOtvscfIx0Cy6Tq/ZhNMOZAkXjLtx+rt/mdd
         btu9sLWTJWfbk7cGLxkNJbr4dTwd0Ew0vA63dfM8=
Message-ID: <1564883160.11223.103.camel@kernel.org>
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
From:   Mimi Zohar <zohar@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tyler Hicks <tyhicks@canonical.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, jejb@linux.ibm.com,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Date:   Sat, 03 Aug 2019 21:46:00 -0400
In-Reply-To: <aff3502c598fb76a1517795edaacd8c8ea330051.camel@linux.intel.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
         <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
         <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
         <20190801163215.mfkagoafkxscesne@linux.intel.com>
         <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
         <20190802142721.GA26616@elm>
         <20190802194226.oiztvme5klkmw6fh@linux.intel.com>
         <20190802202343.GE26616@elm>
         <aff3502c598fb76a1517795edaacd8c8ea330051.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-08-03 at 17:44 +0300, Jarkko Sakkinen wrote:
> On Fri, 2019-08-02 at 15:23 -0500, Tyler Hicks wrote:
> > That wasn't the conclusion that I came to. I prefer Robert's proposed
> > change to trusted.ko.
> > 
> > How do you propose that this be fixed in eCryptfs?
> > 
> > Removing encrypted_key support from eCryptfs is the only way that I can
> > see to fix the bug in eCryptfs. That support has been there since 2011.
> > I'm not sure of the number of users that would be broken by removing
> > encrypted_key support. I don't think the number is high but I can't say
> > that confidently.
> 
> Looking at the documentation [1] it is stated that
> 
> "Encrypted keys do not depend on a TPM, and are faster, as they use AES
> for encryption/decryption."
> 
> Why would you need to remove support for encrypted keys? Isn't it a
> regression in encrypted keys to hard depend on trusted keys given
> what the documentation says?

"Encrypted" key are symmetric keys, which are encrypted/decrypted
either by a "trusted" key or, for development purposes only, a "user"
key.

Mimi
