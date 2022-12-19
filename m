Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E341F650AE7
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Dec 2022 12:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiLSLoo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Dec 2022 06:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiLSLoW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Dec 2022 06:44:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D3FCCF
        for <linux-integrity@vger.kernel.org>; Mon, 19 Dec 2022 03:43:45 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJBFCmX029747;
        Mon, 19 Dec 2022 11:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=/mjacplkWceJWQoPGNcz8N9jXthMmKcfAV48emUnXDI=;
 b=ZDx1P0BUhTK694NFUMJ28lzYTIX2/tqDwRZrwlAC+HePZqOTLhkWbAFg+TQXwAThAOnt
 h8pfsd4sUVWqWzLQK5gU+EHh39DEX2biWK6+Qeg6c4ZpktBUA+i6avxXofpMdqL8h08y
 oXapzfm4d4oGqK6ix9itdQerAuaqR7wFcMqMYZR3U+dkQx2hbWYu1QLVzlN1ziMRhyWq
 fUhKhgtrq0N1IEK7/WJUUxkKHxhJM7YlYd6LPoJVZHctq9NiR2Gd5hYjzHZ2NiqI51VM
 MHKQr1tGQuNLZSHmhlWxrGwZLXMY7ebPyb/w/a4D1TiZeBRLcXLtz3IobjvUFzeNO6QX UQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjpwygs04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 11:43:44 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ90uUx007611;
        Mon, 19 Dec 2022 11:43:43 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3mh6yxd21n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 11:43:43 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BJBhf9060555708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 11:43:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87CD95803F;
        Mon, 19 Dec 2022 11:43:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 497435805A;
        Mon, 19 Dec 2022 11:43:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.175.166])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Dec 2022 11:43:41 +0000 (GMT)
Message-ID: <1a74e603cb6924a19e4995ede5190d2488b2da36.camel@linux.ibm.com>
Subject: Re: Question on loading trusted key with keyctl command
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sughosh Ganu <sughosh.ganu@linaro.org>,
        linux-integrity@vger.kernel.org
Date:   Mon, 19 Dec 2022 06:43:40 -0500
In-Reply-To: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
References: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c6RWeqErLTO5vt6rdYlcDbd8iW2_B8LK
X-Proofpoint-GUID: c6RWeqErLTO5vt6rdYlcDbd8iW2_B8LK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-12-19 at 15:50 +0530, Sughosh Ganu wrote:
> hi,
> I am trying to enable the evm hmac solution on my qemu arm64 virt
> platform running Debian. I am using the swtpm 2.0 implementation for
> the TPM trusted source. Before I get into trying out the evm hmac
> solution on the target system, I wanted to check creating the trusted
> and encrypted keys.  Other details on my set up are as follows
> 
> Distro - Debian 11
> TPM - swtpm
> Linux kernel - Linux version 6.1.0-13032, commit 77856d911a8c [1]
> keyctl --version
> keyctl from keyutils-1.6.1 (Built 2020-02-10)
> 
> When trying to follow the steps highlighted in the
> Documentation/security/keys/trusted-encrypted.rst, I can generate the
> trusted key. However, when I try to load the trusted key using the
> command shown in the document, it throws an error. Has there been a
> change in the code, or am I missing some step when trying to load the
> trusted key?
> 
> Steps that I am following (after having created the SRK).
> 
> # keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
> # keyctl show
> Session Keyring
>  442944693 --alswrv      0     0  keyring: _ses
>  925986946 --alswrv      0 65534   \_ keyring: _uid.0
>  401286062 --alswrv      0     0       \_ trusted: kmk
> # keyctl pipe 401286062 > kmk.blob
> # keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001" @u
> add_key: Invalid argument
> 
> -sughosh
> 
> [1] - I enable trusted and encrypted keys above the said commit

Try deleting/unlinking the existing kmk key before re-loading it.

-- 
thanks,

Mimi



