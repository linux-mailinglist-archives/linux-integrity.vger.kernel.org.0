Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4045338F305
	for <lists+linux-integrity@lfdr.de>; Mon, 24 May 2021 20:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhEXSdU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 May 2021 14:33:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47996 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232547AbhEXSdT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 May 2021 14:33:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14OIEBLS017798;
        Mon, 24 May 2021 14:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EyhXPSGW9WcujibOCJldZGXsgRB+Tv9P9ZLAOXJgMO0=;
 b=D0GJspawn/a434lbYx6kFLbhZhH2riVfWnahK6OZjkH5GtN3UQ/lkVlp5Yo4dDH6hnqk
 hzYrl0AzaVQ2odgyqDpCpXZ26Kdzpmmry2HucjwRcqnuQpI+0nm8mBbwRRWp+4IuieEm
 m+3bqZ5HyRkA9+ll2fxl3ahvbD7cj+5ufTwlVbIphm6hzGiYOgSICsQhRnxe5oS/aagD
 jLUqj2/GXdDY1dqN78nzBqa/lqGSOFt3gzbV97XyPmeCnlFF433fW7RZ0Zjdn6eChtEH
 ERKr3jp+4+lKwELMvBIIE6bn1WNg2IVAtMGH31ZFrdDVeE4Y07SddrofBGWSZ2gSCeGc 2w== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rh858gn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 14:31:45 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14OIUGUm026176;
        Mon, 24 May 2021 18:31:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 38psk8gggd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 18:31:43 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14OIVf7922610240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 18:31:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AF644203F;
        Mon, 24 May 2021 18:31:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70F4042041;
        Mon, 24 May 2021 18:31:39 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.80.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 May 2021 18:31:39 +0000 (GMT)
Message-ID: <34c6aee39110d163c41670b1b6b309288d9986c4.camel@linux.ibm.com>
Subject: Re: [PATCH 6/7] ima: Introduce template field evmxattrs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@srcf.ucam.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 May 2021 14:31:38 -0400
In-Reply-To: <20210520085701.465369-7-roberto.sassu@huawei.com>
References: <20210520085701.465369-1-roberto.sassu@huawei.com>
         <20210520085701.465369-7-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QeOaNC1DtAPJKrLDSTUoj_xb5EYln5QP
X-Proofpoint-GUID: QeOaNC1DtAPJKrLDSTUoj_xb5EYln5QP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_08:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Thu, 2021-05-20 at 10:57 +0200, Roberto Sassu wrote:
> This patch introduces the new template field evmxattrs, which contains the
> number of EVM protected xattrs (u32 in little endian), the xattr names
> separated by \0, the xattr lengths (u32 in little endian) and the xattr
> values. Xattrs can be used to verify the EVM portable signature, if it was
> included with the template fields sig or evmsig.

Verifying the file data hash and the template data hash, the value
extended into the TPM,  are straight forward.  In the first case all
that is needed is the public key, and in the other case the length of
the template data.  Verifying the template data hash doesn't require
any knowledge of the template data format.   All that is needed is the
length of the template data.

This patch set provides all the necessary information for verifying the
EVM portable signature, but it is so much more difficult.  For example,
the security xattrs are listed in whatever order listxattr returns, not
the order in which the hash is calculated.  Does the attestation server
really need to know which xattrs are included or their length?  If that
information is important for the attestation server, then perhaps
provide it separately from the xattrs data.

I'm thinking the attestation server just needs the ability of verifying
the EVM portable signature.   As each field is prefixed with the field
data length, the attestation server should be able to re-calculate the
expected hash - xattrs, followed by the individual "misc" data fields.

thanks,

Mimi

