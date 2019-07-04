Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67EE35FB2E
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfGDPrD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 11:47:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727881AbfGDPrD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 11:47:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64FkdO5070598
        for <linux-integrity@vger.kernel.org>; Thu, 4 Jul 2019 11:47:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thhudwv37-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jul 2019 11:47:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 4 Jul 2019 16:47:00 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 16:46:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64FksMH33947800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 15:46:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 615D1AE04D;
        Thu,  4 Jul 2019 15:46:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB93BAE051;
        Thu,  4 Jul 2019 15:46:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.72])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 15:46:51 +0000 (GMT)
Subject: Re: [PATCH] Revert "tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()"
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Michal Suchanek <msuchanek@suse.de>,
        linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Date:   Thu, 04 Jul 2019 11:46:41 -0400
In-Reply-To: <1562240882.6165.78.camel@linux.ibm.com>
References: <20190701131505.17759-1-msuchanek@suse.de>
         <8e4cc105b748c5395132b4d3d29d0d9b30a8720c.camel@linux.intel.com>
         <cf2ea579-41c2-42da-2df3-0b1f12e1c639@huawei.com>
         <1562240882.6165.78.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070415-0008-0000-0000-000002F9E80F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070415-0009-0000-0000-000022673ADE
Message-Id: <1562255201.6165.143.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040200
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On Thu, 2019-07-04 at 07:48 -0400, Mimi Zohar wrote:
> On Thu, 2019-07-04 at 13:28 +0200, Roberto Sassu wrote:
> > On 7/4/2019 12:03 PM, Jarkko Sakkinen wrote:
> > > On Mon, 2019-07-01 at 15:15 +0200, Michal Suchanek wrote:
> > >> This reverts commit 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400 to avoid
> > >> following crash:
> > > 
> > > Thank you. I think this the right choice for the moment. I fixed
> > > a trivial checkpatch.pl error and added the mandatory tags. Can
> > > you check quickly v2 (just posted)?
> > > 
> > > I already made it available in my master and next.
> > 
> > Could you please wait few days? I would prefer to fix this issue instead
> > of reverting the whole patch.
> 
> Nayna posted a patch late yesterday titled "tpm: fixes uninitialized
> allocated banks for IBM vtpm driver", which addresses this bug.

Now with my review, and with Sachin Sant's and Michal Suchánek
testing, instead of reverting this patch could you pick up Nayna's
patch instead?

thanks!

Mimi

