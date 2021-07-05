Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACAC3BC349
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhGEUBt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 16:01:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229794AbhGEUBt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 16:01:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165JhqA1118160;
        Mon, 5 Jul 2021 15:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=I2JbM1DFGq+XwrF2sowloqIrhyVOAfWu24nYtIxhpdE=;
 b=m/9qIrYvY5HVvJpcOqbBJgx4rcTlJTd0MqwW6MBPmZYaME1KTr73hGgP2ZsnW1KHdLQ3
 /O5SgZZ3hQoVlsn7wzv37TrAbnOJs801XaOGi2zyIIPQQUfTpj2gFrCmTo8uFykK9tXw
 ZN0PD8IOE/wLoy4/nXkpsHl+LBIp2GPiCt4rc4URVBi/eD705bRoGV5OFKdM78LY9mx5
 ALYqNA0Zk8WLS3+rSZPB0GzdZNvXyLOTmNzj5mR537je8asCo6h5LrYMUSNag0G8gIIK
 mzW+t4E2D4lOJTxPUkVt6FYW6m0fta2dO7MtoMlgkqXou0n/eCppPDXGBuEPIhqRh+wV KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39m8g6g9sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 15:59:09 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 165JwFSW170921;
        Mon, 5 Jul 2021 15:59:09 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39m8g6g9s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 15:59:08 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 165Jwvee028976;
        Mon, 5 Jul 2021 19:59:07 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 39jfh8rxbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 19:59:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 165Jx4aH32702802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Jul 2021 19:59:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCB6B4C04E;
        Mon,  5 Jul 2021 19:59:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF99E4C044;
        Mon,  5 Jul 2021 19:59:03 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.121.224])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Jul 2021 19:59:03 +0000 (GMT)
Message-ID: <e80ebe2bfb2e5bd9bf83153789ad9bbcfe5cf916.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 05 Jul 2021 15:59:02 -0400
In-Reply-To: <20210701011323.2377251-3-vt@altlinux.org>
References: <20210701011323.2377251-1-vt@altlinux.org>
         <20210701011323.2377251-3-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E0GBh3UULLkfib2dAu3Gl1NFo4Lx_Tiw
X-Proofpoint-GUID: DdoXjRZITeor7qAnNgOcKj7JMzaLzxNt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_10:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Thu, 2021-07-01 at 04:13 +0300, Vitaly Chikunov wrote:

> @@ -2805,6 +2811,14 @@ int main(int argc, char *argv[])
>  			}
>  			imaevm_params.keyid = keyid;
>  			break;
> +		case 145:
> +			keyid = imaevm_read_keyid(optarg);
> +			if (keyid == 0) {

The function comment indicates zero is returned on error, which is
normally true, but -1 is returned to indicate reading the cert failed. 

> +				log_err("Error reading keyid.\n");
> +				exit(1);
> +			}
> +			imaevm_params.keyid = keyid;

As a result, imaevm_params.keyid is set to -1, which the "--keyid="
case would detect, but isn't detected here.

> +			break;
>  		case '?':
>  			exit(1);
>  			break;
> diff --git a/src/imaevm.h b/src/imaevm.h
> index fe244f1..491f136 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> 
> +/**

kernel doc?  :)

> + * imaevm_read_keyid() - Read 32-bit keyid from the cert file
> + * @certfile:	File with certificate in PEM or DER form.
> + *
> + * Try to read keyid from Subject Key Identifier (SKID) of x509 certificate.
> + * Autodetect if cert is in PEM (tried first) or DER encoding.
> + *
> + * Return: 0 on error, logged error message;
> + *         32-bit keyid in host order.

As mentioned above, -1 could be returned.

> + */
> +uint32_t imaevm_read_keyid(const char *certfile)
> +{
> +	uint32_t keyid_be = 0;
> +	X509 *x;
> +
> +	/* true: to load in DER form too. */
> +	if (!(x = read_cert(certfile, true)))
> +		return -1;
> +	extract_keyid(&keyid_be, x, certfile);
> +	/* On error keyid_be will not be set, returning 0. */

Ok

thanks,

Mimi

> +	X509_free(x);
> +	return ntohl(keyid_be);
> +}
> +
>  static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>  {
>  	FILE *fp;

