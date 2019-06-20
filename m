Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE574CE89
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2019 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfFTNWI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Jun 2019 09:22:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731743AbfFTNWI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Jun 2019 09:22:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KDCbIj102925
        for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2019 09:22:07 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t89t8k98h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2019 09:22:06 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 20 Jun 2019 14:22:04 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 14:22:02 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KDM12e61604064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 13:22:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 270BC4C046;
        Thu, 20 Jun 2019 13:22:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A94B4C04A;
        Thu, 20 Jun 2019 13:22:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.247])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 13:22:00 +0000 (GMT)
Subject: Re: [PATCH v5 06/11] ima-evm-utils: Start converting find_keyid to
 use EVP_PKEY API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 20 Jun 2019 09:21:49 -0400
In-Reply-To: <20190620010713.wfmkjkf3fprgc3h6@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
         <20190618135623.6861-7-vt@altlinux.org>
         <1560947190.3975.23.camel@linux.ibm.com>
         <20190619154339.e3kjc3niahwng64h@altlinux.org>
         <1560962810.3975.57.camel@linux.ibm.com>
         <20190620010713.wfmkjkf3fprgc3h6@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062013-0012-0000-0000-0000032AE1D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062013-0013-0000-0000-000021640828
Message-Id: <1561036909.4525.29.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=915 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200099
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

> > > > If so, why are there other changes in this patch?
> > > 
> > > There is no other changes beside stated in description.
> > 
> > Are the changes from read_pub_key() to read_pub_pkey() and
> > calc_keyid_v2() to calc_pkeyid_v2() needed for making find_keyid() a
> > wrapper for find_keyid_pkey()?
> 
> Of course. `entry->key' now have different type. If we keep old type
> (RSA) where will be nothing to wrap.

The question wasn't if the changes in init_public_keys() need to be
made, the question is its correlation to find_keyid().  Unlesss I'm
missing something, find_keyid() is only called by verify_hash_v2(),
not calc_keyid_v2().

Mimi

