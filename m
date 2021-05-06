Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D454B375C22
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 22:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhEFUSL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 May 2021 16:18:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231270AbhEFUSL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 May 2021 16:18:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146K35TH196218;
        Thu, 6 May 2021 16:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rxvEHLYZAzP4/3GJIRJTPefkx82/kuIhPT4f8rQVpv4=;
 b=H8YSB77vDPjEtvWsBretGy6I5zUY9Rl71MrXhLrm95SMaaq+L1VaW95jLlp9gIeTiXrc
 /wqKIHfjiOCb42Gg51jUFem9xLtoDs4OY5x8/jCOqKOmSyyeD8sQu7k425KJgfJvDLdf
 lkW8hUqvlDNFbPCx3E59yjEWhr214UBUjBQszr7B7CVS/n0451GyIjy+132iG9bHBGPX
 H3FPwTz+YUSeTDDQV7npXoDgWrPDuJ553yFbkjNqgk7/tsXm4K/MT+3KyeF7RzQwiYzy
 XPt4Y0zZWlEx3sw3Qd6SfV/cHKA+QdTCVTyBTUYdPPMdwL+q0xmXsO6VCPNtCEkf1XYY bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38cpw6gppq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 16:17:10 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 146K3Evf196579;
        Thu, 6 May 2021 16:17:10 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38cpw6gppd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 16:17:09 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 146KCNnb017091;
        Thu, 6 May 2021 20:17:09 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 38c1my1hye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 20:17:09 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 146KH87P32440820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 20:17:08 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 525AA28059;
        Thu,  6 May 2021 20:17:08 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06FB928058;
        Thu,  6 May 2021 20:17:07 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 20:17:07 +0000 (GMT)
Subject: Re: [PATCH v5 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20210506034702.216842-1-vt@altlinux.org>
 <20210506034702.216842-3-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <665d1368-c7a6-4aa4-1d43-fb65c692d69c@linux.ibm.com>
Date:   Thu, 6 May 2021 16:17:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506034702.216842-3-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nHisC-S6WMX4G74b9FS4HgCADNLJ8DDM
X-Proofpoint-GUID: DThc3Hi9-_T9bknU0bPsNnxHjDXyOOdz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105060138
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/5/21 11:47 PM, Vitaly Chikunov wrote:
>   
> +enum keyid_file_type {
> +	KEYID_FILE_PEM_KEY = 0,
> +	KEYID_FILE_UNK_CERT,
> +};
> +
> +/*
> + * @keyid:	Pointer to 32-bit value in network order, can be unaligned.
> + * @file_type:	KEYID_FILE_PEM_KEY - PEM encoded private key file with possible
> + *		appended x509 cert;
> + *		KEYID_FILE_UNK_CERT - x509 cert file (maybe PEM, maybe DER
> + *		encoded).
> + * Return:	0 on error; 1 on success.

Many other APIs of the library return -1 on error and 0 on success...


