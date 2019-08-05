Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEF08212E
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfHEQFH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Aug 2019 12:05:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40456 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHEQFH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Aug 2019 12:05:07 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1hufTk-0006Pg-P1; Mon, 05 Aug 2019 16:04:57 +0000
Date:   Mon, 5 Aug 2019 11:04:52 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jejb@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
Message-ID: <20190805160451.GB3449@elm>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
 <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
 <20190801163215.mfkagoafkxscesne@linux.intel.com>
 <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
 <20190802142721.GA26616@elm>
 <20190802194226.oiztvme5klkmw6fh@linux.intel.com>
 <20190802202343.GE26616@elm>
 <e10f7b04-3d63-435e-180e-72a084ac4bab@huawei.com>
 <1565020459.11223.179.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565020459.11223.179.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-08-05 11:54:19, Mimi Zohar wrote:
> On Mon, 2019-08-05 at 16:50 +0200, Roberto Sassu wrote:
> > Regarding Mimi's proposal to avoid the issue by extending the PCR with
> > zeros, I think it also achieve the goal. 
> 
> Roberto, removing the following code from init_digests() would be the
> equivalent to the prior code, without needing to make any other
> changes.  Let's keep it simple.  Do you want to post the patch with
> the change, or should I?
> 
>         ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
>         if (ret < 0)
>                 return ret;
>         if (ret < TPM_MAX_DIGEST_SIZE)
>                 return -EFAULT;
> 
> As I can't duplicate the problem, it would need to be tested by others
> experiencing the problem.

The bug reporter tested Roberto's last patch:

 https://bugzilla.kernel.org/show_bug.cgi?id=203953#c8

We should Cc the reporter on future patches or at least leave another
testing request in the bugzilla.

Tyler

> 
> thanks,
> 
> Mimi
> 
