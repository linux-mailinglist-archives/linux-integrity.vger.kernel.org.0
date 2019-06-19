Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07414BEA8
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2019 18:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfFSQrC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 12:47:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbfFSQq7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 12:46:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JGiB5k117015
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 12:46:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t7qy7u0w1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 12:46:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 19 Jun 2019 17:46:56 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 17:46:52 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5JGkpHA37749036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 16:46:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6998EA4051;
        Wed, 19 Jun 2019 16:46:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2833A404D;
        Wed, 19 Jun 2019 16:46:50 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jun 2019 16:46:50 +0000 (GMT)
Subject: Re: [PATCH v5 06/11] ima-evm-utils: Start converting find_keyid to
 use EVP_PKEY API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 19 Jun 2019 12:46:50 -0400
In-Reply-To: <20190619154339.e3kjc3niahwng64h@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
         <20190618135623.6861-7-vt@altlinux.org>
         <1560947190.3975.23.camel@linux.ibm.com>
         <20190619154339.e3kjc3niahwng64h@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061916-4275-0000-0000-00000343D26F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061916-4276-0000-0000-00003853FE7A
Message-Id: <1560962810.3975.57.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190135
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-06-19 at 18:43 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Wed, Jun 19, 2019 at 08:26:30AM -0400, Mimi Zohar wrote:
> > On Tue, 2019-06-18 at 16:56 +0300, Vitaly Chikunov wrote:
> > > New find_keyid_pkey() accepts EVP_PKEY. Old find_keyid() calls
> > > find_keyid_pkey(), but still return RSA key.
> > > 
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > 
> > With titles starting with "Start converting", it leaves me wondering
> > whether these patches are bisect safe.  Does this patch make
> > find_keyid() a wrapper for find_keyid_pkey()?
> 
> Yes.
> 
> > Do all callers of find_keyid() continue to work properly?
> 
> Yes.
> 
> > If so, why are there other changes in this patch?
> 
> There is no other changes beside stated in description.

Are the changes from read_pub_key() to read_pub_pkey() and
calc_keyid_v2() to calc_pkeyid_v2() needed for making find_keyid() a
wrapper for find_keyid_pkey()?

> 
> > If you haven't already, please make sure that after each patch is
> > applied, the code not only compiles cleanly, but works properly.
> 
> Yes, they compile and work properly after each patch.

thanks!

Mimi

