Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1E7A0395
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfH1Np5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 09:45:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbfH1Nn5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 09:43:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SDcWNB116861
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 09:43:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unsw52gv4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 09:43:55 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 28 Aug 2019 14:43:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 14:43:46 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SDhjxr37879864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 13:43:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D0A311C052;
        Wed, 28 Aug 2019 13:43:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A6C111C05C;
        Wed, 28 Aug 2019 13:43:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.129.156])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 13:43:42 +0000 (GMT)
Subject: Re: [PATCH v12 00/11] Appended signatures support for IMA appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date:   Wed, 28 Aug 2019 09:43:41 -0400
In-Reply-To: <9682b5d0-1634-2dd0-2cbb-eb1fa8ba7423@linux.microsoft.com>
References: <20190628021934.4260-1-bauerman@linux.ibm.com>
         <9682b5d0-1634-2dd0-2cbb-eb1fa8ba7423@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082813-4275-0000-0000-0000035E558B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082813-4276-0000-0000-0000387089DF
Message-Id: <1566999821.6115.14.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=912 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jordan,

On Mon, 2019-08-26 at 15:46 -0700, Jordan Hand wrote:
> On 6/27/19 7:19 PM, Thiago Jung Bauermann wrote:
> > On the OpenPOWER platform, secure boot and trusted boot are being
> > implemented using IMA for taking measurements and verifying signatures.
> > Since the kernel image on Power servers is an ELF binary, kernels are
> > signed using the scripts/sign-file tool and thus use the same signature
> > format as signed kernel modules.
> > 
> > This patch series adds support in IMA for verifying those signatures.
> > It adds flexibility to OpenPOWER secure boot, because it allows it to boot
> > kernels with the signature appended to them as well as kernels where the
> > signature is stored in the IMA extended attribute.
> 
> I know this is pretty late, but I just wanted to let you know that I
> tested this patch set on x86_64 with QEMU.
> 
> That is, I enrolled a key to _ima keyring, signed my kernel and modules
> with appended signatures (with scripts/sign-file), set the IMA policy to
> appraise and measure my kernel and modules. Also tested kexec appraisal.
> 
> You can add my tested-by if you'd like.

I really appreciate your testing.  Based on the recent
Documentation/maintainer/rebasing-and-merging.rst,  I'm trying not to
rebase patches already staged in linux-next.  Patches are first being
staged in the next-queued-testing branch.

FYI, I just posted a patch that adds IMA appended signature support to
test_kexec_file_load.sh.

thanks,

Mimi

