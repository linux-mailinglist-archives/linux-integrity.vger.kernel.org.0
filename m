Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5C16C072
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 13:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgBYMLn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Feb 2020 07:11:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729048AbgBYMLn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 07:11:43 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PC9thh072643
        for <linux-integrity@vger.kernel.org>; Tue, 25 Feb 2020 07:11:41 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb12c1euv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 25 Feb 2020 07:11:41 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 25 Feb 2020 12:11:39 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Feb 2020 12:11:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PCBa5C54984942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 12:11:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA2AD11C04C;
        Tue, 25 Feb 2020 12:11:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C7B211C058;
        Tue, 25 Feb 2020 12:11:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.229.165])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 12:11:36 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        linux-integrity@vger.kernel.org
Date:   Tue, 25 Feb 2020 07:11:35 -0500
In-Reply-To: <63ba8482-0085-f2d3-dbb9-70bb81990f07@rosalinux.ru>
References: <63ba8482-0085-f2d3-dbb9-70bb81990f07@rosalinux.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022512-4275-0000-0000-000003A54C81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022512-4276-0000-0000-000038B96239
Message-Id: <1582632695.10443.174.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=18
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=797
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250098
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mikhail,

On Sun, 2020-02-16 at 14:10 +0300, Mikhail Novosyolov wrote:
> LibreSSL in most cases can be used as a drop-in replacement of OpenSSL.
> Commit 07d799cb6c37 "ima-evm-utils: Preload OpenSSL engine via '--engine' option"
> added OpenSSL-specific functions: "engines" were removed from LibreSSL long ago.
> Instead of requiring to attach GOST support via an external library ("engine"),
> LibreSSL has build-in implementation of GOST.
> 
> Commit ebbfc41ad6ba "ima-evm-utils: try to load digest by its alias" is also not OK
> for LibreSSL because LibreSSL uses different digest names:
> md_gost12_256 -> streebog256
> md_gost12_512 -> streebog512
> 
> Example how it works when linked with LibreSSL:
> $ libressl dgst -streebog256 testfile
> streebog256(a)= 04123f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
> $ evmctl -v ima_hash -a streebog256 testfile
> hash(streebog256): 04123f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
> $ evmctl -v ima_hash -a md_gost12_256 testfile
> EVP_get_digestbyname(md_gost12_256) failed
> 
> TODO: it would be nice to map
> md_gost12_256 <-> streebog256
> md_gost12_512 <-> streebog512
> in evmctl CLI arguements to make the same commands work on systems both
> where evmctl is linked with LibreSSL and with OpenSSL.
> 
> Fixes: 07d799cb6c37 ("ima-evm-utils: Preload OpenSSL engine via '--engine' option")
> Fixes: ebbfc41ad6ba ("ima-evm-utils: try to load digest by its alias")
> Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>

Patches need to be posted as plain text, not Mime.  Please use "git
format-patch" and "git send-email".

thanks,

Mimi

