Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64165372B02
	for <lists+linux-integrity@lfdr.de>; Tue,  4 May 2021 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhEDN3W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 09:29:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231127AbhEDN3V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 09:29:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 144DJAwl183227;
        Tue, 4 May 2021 09:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OpSm5X2BccZQrJ9ZnkEKpGbJsoipKX+g8eyGjdOFf9M=;
 b=sbDYTtB2wNPFWLum657e+CbSqUH3lcbAK95bC4O/Ag6OU3cIEqhGjrGLmea0rHAhDBB0
 dIelsM9TYeNhuJAq+zSaEK37w1DhYpw/WAMoEx557UvsD/Khseb8/KWqwQBgqEfUDwfV
 gGVurlCGY0v9E6ZWi2ZIsdr/Tk4Y7BWst5taqla0kpsHc+jm5NceaRV7ENK8RfS1voTb
 95SPLLJDRE9LjZrAXKRx46LhxDK7GZEA+hil91WNlUtW6Xrs3TrBvq3yPcq1zNDt4xXH
 928CITaZG54ycFJcyQNtto/eMax3Gj3RpEVvjFB0lK2GXVT2BTffIrmdaxFl/48L74Cx Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38b72206qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 09:28:25 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 144DJr7r186036;
        Tue, 4 May 2021 09:28:24 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38b72206qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 09:28:24 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144DMTgv003820;
        Tue, 4 May 2021 13:28:24 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 388xm9av1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 13:28:24 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 144DSNeG13042284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 May 2021 13:28:23 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CFFC112066;
        Tue,  4 May 2021 13:28:23 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D9E2112061;
        Tue,  4 May 2021 13:28:23 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 May 2021 13:28:23 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter0@gmail.com>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-3-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8dfb94e3-d343-191c-1013-8231874a2236@linux.ibm.com>
Date:   Tue, 4 May 2021 09:28:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504043357.4093409-3-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nbHMYaw5VW_h-PPCfh9Qo38XubivVpQK
X-Proofpoint-GUID: PYmgBr5prALCTXsF7H_cTdSOfTgDOb-X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_07:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105040096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/4/21 12:33 AM, Vitaly Chikunov wrote:
> Allow user to specify `--keyid @/path/to/cert.pem' to extract keyid from
> SKID of the certificate file. PEM or DER format is auto-detected.
>
> `--keyid' option is reused instead of adding a new option (like possible
> `--cert') to signify to the user it's only keyid extraction and nothing
> more.
>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
>
> +/* Extract keyid from SKID of the cert. No return on error. */
> +static unsigned long int extract_keyid(const char *certfile)
> +{

This could be a library function imaevm_cert_extract_keyid or so, which 
could be useful for other users of the library.

