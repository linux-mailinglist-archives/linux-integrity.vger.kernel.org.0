Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C8B21792
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfEQLTy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 07:19:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728382AbfEQLTy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 07:19:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HBDcdx014248
        for <linux-integrity@vger.kernel.org>; Fri, 17 May 2019 07:19:53 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2shsrye1mr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 17 May 2019 07:19:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 17 May 2019 12:19:50 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 May 2019 12:19:47 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4HBJkTK52428856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 11:19:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33A4AA405F;
        Fri, 17 May 2019 11:19:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61975A4054;
        Fri, 17 May 2019 11:19:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.67])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 May 2019 11:19:45 +0000 (GMT)
Subject: Re: [PATCH] ima: skip verifying TPM 2.0 PCR values
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Fri, 17 May 2019 07:19:34 -0400
In-Reply-To: <20190517065116.GA8170@dell5510>
References: <1558041162.3971.2.camel@linux.ibm.com>
         <20190517065116.GA8170@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051711-0016-0000-0000-0000027CBA58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051711-0017-0000-0000-000032D9969D
Message-Id: <1558091974.4507.60.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170075
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-05-17 at 08:51 +0200, Petr Vorel wrote:

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > index 0ffc3c02247d..ebe4b4c360e4 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > @@ -88,6 +88,14 @@ test2()
> >  	tst_res TINFO "verify PCR values"
> >  	tst_check_cmds evmctl
> 
> > +	local tpm_description="/sys/class/tpm/tpm0/device/description"
> > +	if [ -f "$tpm_description" ]; then
> > +		if grep -q "^\TPM 2.0" $tpm_description; then

> I guess the backslash in "^\TPM 2.0" is a typo.
> If yes, no need to repost, I'll fix it when applying your patch.
> + I'd prefer join 2 ifs into single one, but that's just matter of preference,
> not important.

Thank you for fixing it.  I'd just like to hear from others first, if
this is correct way to differentiate between TPM 1.2 and TPM 2.0.

Mimi


> > +			tst_res TCONF "TPM 2.0 enabled, but not supported"
> > +			return 0
> > +		fi
> > +	fi
> > +
> >  	tst_res TINFO "evmctl version: $(evmctl --version)"
> 
> >  	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"
> 

