Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56243E15E
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Oct 2021 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhJ1M7l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Oct 2021 08:59:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229946AbhJ1M7l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Oct 2021 08:59:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SClxWL011260;
        Thu, 28 Oct 2021 12:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=INVjYdr5gOcGiPS4sk9gH2v6Lz9ouI5VLmcx1ztSyQo=;
 b=Ke+uy7DrTihhmaJ3oHitCrskzuXMZxX65iUNrDO1fwQOHgFe0eEX3fDSbR36Ej53CmFZ
 dwnsOfH25Bd01RPAqcAwwJWg9xdyh3ikyc3Xjx04duti83cWHccTvVOx2xA7pQSEv3lf
 ocrlk5cg2G73UfVOZ1Bj8FeI/2v976cuMVDx3K4HvKz6aWryZUIdVnQnvCjUfvonWnLU
 wCe78Y/MzkQDV8jTE78xikRsOMvcmkIZV06kGXnNbrNZmbKOo8OpQP7Q3uqJFD4MrmkU
 8rA/ueY0kn5iwJ/ZGUroB8Ugmg3XXR4e26CNZDfeIYtXPviN4qkLf820SjKOHisjUHza UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3byv6er4qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 12:56:46 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19SCmTlE012057;
        Thu, 28 Oct 2021 12:56:45 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3byv6er4qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 12:56:45 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19SCrb9m026734;
        Thu, 28 Oct 2021 12:56:44 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3bx4f8vvn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 12:56:44 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19SCuhvn48955892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 12:56:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E5FD7805C;
        Thu, 28 Oct 2021 12:56:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 396277806B;
        Thu, 28 Oct 2021 12:56:40 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.163.12.226])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Oct 2021 12:56:39 +0000 (GMT)
Message-ID: <5b4ef3212232836b02920e57014d69300b484f20.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] tpm: use SM3 instead of SM3_256
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Thu, 28 Oct 2021 08:56:38 -0400
In-Reply-To: <20211026075626.61975-3-tianjia.zhang@linux.alibaba.com>
References: <20211026075626.61975-1-tianjia.zhang@linux.alibaba.com>
         <20211026075626.61975-3-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GWOqV3gAEq8QSKNIJu50pIXY1-qMcU6E
X-Proofpoint-ORIG-GUID: xFCfz9k46q-l0FnrN5q9B3PNV22O0QGq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280069
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-10-26 at 15:56 +0800, Tianjia Zhang wrote:
> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
> SM3 always produces a 256-bit hash value and there are no plans for
> other length development, so there is no ambiguity in the name of
> sm3.

Please just drop this piece.

[...]
>         hash=         hash algorithm name as a string. For TPM 1.x
> the only
>                       allowed value is sha1. For TPM 2.x the allowed
> values
> -                     are sha1, sha256, sha384, sha512 and sm3-256.
> +                     are sha1, sha256, sha384, sha512 and sm3.

the hash parameter is an external ABI we can't simply change ... as
Jarkko already told you.

The rest are constants defined in the TPM standard, which we shouldn't
change because then it makes everyone wonder why we're deviating.

James




