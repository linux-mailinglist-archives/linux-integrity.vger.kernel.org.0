Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6AB38F2E8
	for <lists+linux-integrity@lfdr.de>; Mon, 24 May 2021 20:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhEXSXx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 May 2021 14:23:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232516AbhEXSXx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 May 2021 14:23:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14OI3CR6116304;
        Mon, 24 May 2021 14:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fnHpK9+VpzUR3Ss627T2ieVAfKo8WEgjF+M+DZqxg8k=;
 b=ToWveYqdn2gyvcVG+p15LzAuTYDvrBwrAAKakr5UvSIM5sr4n2mmSVNfAo+PkYOvz+fU
 y9dMlzLW2aGtYTRwRzv/yghGUkPWciJbLRUrShgwl60dkW/qFBSX2oSa2reb6WheRgaV
 fqpimVo3QDcnuTLrYL3bVLZdrb9hhSHfFMeZ3140TuoVWvIfQqf9pxaUrAXaAGN66Ley
 0O5/R20ZiHtsQWlDDuJu6pun6jzQ8TRO5XypC9fD+OF/W4rMB6spDhWkQbf7CqNOvm8e
 zZZT9YvpIYbfpSKQJ5vVKhozTZqtE4Ar/sInQjhDUg3+ClVyuIWIkzQs2EQFv2fXioB3 BQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38rh0bgp4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 14:21:49 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14OHqUDj007909;
        Mon, 24 May 2021 18:21:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 38psk88gh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 18:21:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14OILjEF30540070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 18:21:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D9F3A4053;
        Mon, 24 May 2021 18:21:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE74EA4040;
        Mon, 24 May 2021 18:21:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.80.46])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 May 2021 18:21:43 +0000 (GMT)
Message-ID: <17d48530e2ec9a6f7e2cb868d8ddf8dcd3be14da.camel@linux.ibm.com>
Subject: Re: [PATCH 5/7] evm: Verify portable signatures against all
 protected xattrs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@srcf.ucam.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 May 2021 14:21:43 -0400
In-Reply-To: <20210520085701.465369-6-roberto.sassu@huawei.com>
References: <20210520085701.465369-1-roberto.sassu@huawei.com>
         <20210520085701.465369-6-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JkAx4NJtmjcUiSTIMUKbB1FOKQFQpv6O
X-Proofpoint-ORIG-GUID: JkAx4NJtmjcUiSTIMUKbB1FOKQFQpv6O
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_08:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 mlxscore=0 clxscore=1011 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-05-20 at 10:56 +0200, Roberto Sassu wrote:
> Currently, the evm_config_default_xattrnames array contains xattr names
> only related to LSMs which are enabled in the kernel configuration.
> However, EVM portable signatures do not depend on local information and a
> vendor might include in the signature calculation xattrs that are not
> enabled in the target platform.
> 
> Just including all xattrs names in evm_config_default_xattrnames is not a
> safe approach, because a target system might have already calculated
> signatures or HMACs based only on the enabled xattrs. After applying this
> patch, EVM would verify those signatures and HMACs with all xattrs instead.
> The non-enabled ones, which could possibly exist, would cause a
> verification error.
> 
> Thus, this patch adds a new field named enabled to the xattr_list
> structure, which is set to true if the LSM associated to a given xattr name
> is enabled in the kernel configuration. The non-enabled xattrs are taken
> into account in only evm_calc_hmac_or_hash(), if the passed security.evm
> type is EVM_XATTR_PORTABLE_DIGSIG.
> 
> The new function evm_protected_xattr_if_enabled() has been defined so that
> IMA can include all protected xattrs and not only the enabled ones in the
> measurement list, if the new template field evmxattrs has been included in
> the template format.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Nice, I really like this idea.

Mimi

