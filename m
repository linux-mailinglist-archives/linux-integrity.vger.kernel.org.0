Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75307376696
	for <lists+linux-integrity@lfdr.de>; Fri,  7 May 2021 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbhEGOCn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 May 2021 10:02:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237366AbhEGOC0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 May 2021 10:02:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147DXcPP009251;
        Fri, 7 May 2021 10:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+gh4Q+MqBeXm8lgHBXuEyaqi3s9396RBX8+/j5VJ/dw=;
 b=IJfrUupjUxsWTqzHTrBqiSbt0PbTqTVcNspVq63D64TMOs7fycqqr5z903uCeDpIolbv
 8GbUQR9N/sFbqL3bxI4gB0fHsa8dtMeBdwo8A64BwjD+OspHjgiXWm0bcZvs/plTd65N
 3AvL9vTrVQ1YHIAyIK+jGxDNnpwsXAQ8Yr9wznagBvMRZfub3cORisxrEGbioq1dcbi5
 VqMrDPkrJycP5k0WKd/7ShJLbaF2Pud9DQQo1zZshR/3efs+JjkQ5RYpUwo6MDhGOVDi
 dYjVlk1Egu+xrosrVwBqCa5JAkHnx+6Es93SAvjLzFOPtfgudpL5InFR+8DG0j1Qo+Jj Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38d68khg74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 10:01:23 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 147DZ9TS019192;
        Fri, 7 May 2021 10:01:23 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38d68khg64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 10:01:23 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 147DsgXO004492;
        Fri, 7 May 2021 14:01:22 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 38cvef49q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 14:01:22 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 147E1LWx9306828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 May 2021 14:01:21 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FE6D112064;
        Fri,  7 May 2021 14:01:21 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17E74112066;
        Fri,  7 May 2021 14:01:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  7 May 2021 14:01:21 +0000 (GMT)
Subject: Re: [PATCH v5 0/3] ima-evm-utils: Add --keyid option
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20210506034702.216842-1-vt@altlinux.org>
 <a187174e-9a57-9aad-790b-41eaca424e35@linux.ibm.com>
 <20210507014332.qrgvzaana53yzp4g@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <312a94ba-dba7-139e-b93a-c10a5cae34a4@linux.ibm.com>
Date:   Fri, 7 May 2021 10:01:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210507014332.qrgvzaana53yzp4g@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ykwRegrYUB_4ZvY22DerWK4IkXXgy71d
X-Proofpoint-ORIG-GUID: cOrJEmz9VuPyB7LMtvZYOzdG8ue2_PES
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_04:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105070093
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/6/21 9:43 PM, Vitaly Chikunov wrote:
> Stefan,
>
> On Thu, May 06, 2021 at 04:10:25PM -0400, Stefan Berger wrote:
>> On 5/5/21 11:46 PM, Vitaly Chikunov wrote:
>>> Allow user to set signature's keyid using `--keyid' option. Keyid should
>>> correspond to SKID in certificate. When keyid is calculated using SHA-1
>>> in libimaevm it may mismatch keyid extracted by the kernel from SKID of
>>> certificate (the way public key is presented to the kernel), thus making
>>> signatures not verifiable. This may happen when certificate is using non
>>> SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
>>> As a last resort user may specify arbitrary keyid using the new option.
>>> Certificate @filename could be used instead of the hex number. And,
>>> third option is to read keyid from the cert appended to the key file.
>>>
>>> These commits create backward incompatible ABI change for libimaevm,
>>>    thus soname should be incremented on release.
>> I hope this will not be forgotten about. Maybe it should be part of this
>> series here?
> https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html
>
>    "Update the version information only immediately before a public
>    release of your software."
>
> I believe we should follow this.

As long as the maintainers are not forgetting about it...


One other thing is the naming of the function you are adding to the 
library. Here are the last few changes to imaevm.h:

+int imaevm_hash_algo_from_sig(unsigned char *sig);
+const char *imaevm_hash_algo_by_id(int algo);


@@ -204,12 +206,12 @@ struct RSA_ASN1_template {
 š#defineššššššš NUM_PCRS 20
 š#define DEFAULT_PCR 10

-extern struct libevm_params params;
+extern struct libimaevm_params imaevm_params;

-void do_dump(FILE *fp, const void *ptr, int len, bool cr);
-void dump(const void *ptr, int len);
+void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool cr);
+void imaevm_hexdump(const void *ptr, int len);
 šint ima_calc_hash(const char *file, uint8_t *hash);
-int get_hash_algo(const char *algo);
+int imaevm_get_hash_algo(const char *algo);
 šRSA *read_pub_key(const char *keyfile, int x509);
 šEVP_PKEY *read_pub_pkey(const char *keyfile, int x509);


It looks like the author (actually you) tried to establish some sort of 
namespace for the function with the prefix 'imaevm_'. Maybe the newly 
added one should also have that prefix?


