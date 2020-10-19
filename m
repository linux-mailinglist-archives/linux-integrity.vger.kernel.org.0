Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400202930FD
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 00:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbgJSWNF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 18:13:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32942 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387948AbgJSWNF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 18:13:05 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JM3Vmp180148;
        Mon, 19 Oct 2020 18:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Czt2yrCb1hKlgjYDszLaJZgCAUgyTWl8ofXlI/7Np0I=;
 b=WclLBFNbbMe02DA0gxKWto9WIF5ogHkFU38UxePhYqKHXc9lGfYzI87rmYVw0hQRx3IF
 3crm5kvI8LijR+BO0Hiwh0gDXdTBBNFzu/rj10ezzfA5uw36YzZoX7zdjPoYJiY8Gbmw
 l95dK9c5/qmR6WH+6yH4G3gTEhTXy/MxIQsPBy58uEIhD8Ns8mqGvXREb0i6OrMNLM51
 FYhxWn3TW01W448MFU/HRyQKPHHshmUDkX+P+kQFyN0FUzkVRzB5XM9NxAnStz7HD/91
 B4V2rlBzYXYdb0JuOv2uy4O6fdSPJH2p4LwBGOn+Hr3rQefbLoRhhpVFBF0xQI9iPIf4 nw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 349k738bbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 18:13:00 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09JM2Q5V031441;
        Mon, 19 Oct 2020 22:12:59 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 347r88ajdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 22:12:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09JMCu5d12976452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 22:12:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C92EA5204F;
        Mon, 19 Oct 2020 22:12:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.104.43])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B0B9F52052;
        Mon, 19 Oct 2020 22:12:55 +0000 (GMT)
Message-ID: <9dd83103f724484a8f1febb37b54616d136930fe.camel@linux.ibm.com>
Subject: Re: [PATCH] file2bin: Pass the right values to size and count
 parameters for fread()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org
Date:   Mon, 19 Oct 2020 18:12:54 -0400
In-Reply-To: <20201019200526.12678-1-nramas@linux.microsoft.com>
References: <20201019200526.12678-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_11:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=2
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190145
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Mon, 2020-10-19 at 13:05 -0700, Lakshmi Ramasubramanian wrote:
> The 2nd parameter to fread() namely "size" specifies the size, in
> bytes of each element to be read, and the 3rd parameter namely "count"
> specifies the number of elements, each one with a size of "size" bytes.
> 
>  size_t fread ( void * ptr, size_t size, size_t count, FILE * stream );
> 
> But in the function file2bin() the values passed to "size" and "count"
> are reversed causing the function to return an error eventhough the file
> was sucdessfully read.
> 
> Pass the right values to "size" and "count" parameters for fread() in
> the function file2bin().
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  src/evmctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 7ad1150..d49988e 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -221,7 +221,8 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
>  		fclose(fp);
>  		return NULL;
>  	}
> -	if (fread(data, len, 1, fp) != len) {
> +
> +	if (fread(data, 1, len, fp) != len) {
>  		log_err("Failed to fread %zu bytes: %s\n", len, name);
>  		fclose(fp);
>  		free(data);

Wasn't this problem addressed by Vitaly's patch.  Please look at commit
c89e8508864b ("ima-evm-utils: Fix reading of sigfile").

Mimi


