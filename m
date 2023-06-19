Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942E5735BB9
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jun 2023 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjFSP71 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jun 2023 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFSP70 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jun 2023 11:59:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C51A4
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jun 2023 08:59:24 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JFvEwC025733;
        Mon, 19 Jun 2023 15:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yX717uOWd0q4SlGBhWpd2RavZnYLfjigdvN62uO9/4g=;
 b=UdgpEL9C/0fSLF5gbGKJqdNqdbjbTpaRLVmHsVnAkwLe7MuBOCQ4QBmEmvQ80nHT6H+w
 GWFAelpLVpUn4jLcZ5QWR/rPhLSArXx5eEd4hHe9HUR9UcnE6b1JGht/Eo1xzziyw7hm
 okoPf9eAvalwfZkZXLG2Z84hrTG2xQrMfaZ49XBTkeh5gVfyH4Vr6Y1DbQbVR1yDDp3/
 KRY5zgYeGi5xdU53bhxuyyG1ItlgRRPovcBp50R2nHeCYusIZencVz8BNeaGjGPpgLSu
 VcRwKrNwJAacogsDwe88+Lf4itKEbg+5NWypxYvZMolvby0eEkPZ3H8uQEu6Q5jJNTV4 XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rat3x80wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 15:59:05 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35JFvrF7027193;
        Mon, 19 Jun 2023 15:59:05 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rat3x80wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 15:59:05 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35JDVATq031780;
        Mon, 19 Jun 2023 15:59:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3r94f61k1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 15:59:04 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35JFx3ME58524016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 15:59:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1915758053;
        Mon, 19 Jun 2023 15:59:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4632B58059;
        Mon, 19 Jun 2023 15:59:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jun 2023 15:59:02 +0000 (GMT)
Message-ID: <16e44c4e-98de-ecc9-167f-3ffe4497180d@linux.ibm.com>
Date:   Mon, 19 Jun 2023 11:59:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 ima-evm-utils 3/4] Add --hmackey option for evmctl
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
 <20230616192358.314906-4-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230616192358.314906-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z6bL8dBUwgVkyULSBuN6pVyxf-FXA_qa
X-Proofpoint-GUID: K9pBXzVAGi0TdyWkXA2qkB7Uwf6L0r_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 6/16/23 15:23, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> "evmctl --hmac" was only enabled in debug mode, since the hmac key was not
> exposed to userspace. It was never really used. With the ability of
> creating an encrypted key based on user-provided decrypted data, verifying
> the EVM hmac is now feasible.
> 
> Make "evmctl --hmac" more configurable by adding the --hmackey option, to
> specify an alternate path for the file containing the HMAC key. By default
> evmctl looks in /etc/keys/evm-key-plain.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   README       |  3 ++-
>   src/evmctl.c | 12 ++++++++++--
>   src/imaevm.h |  1 +
>   3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/README b/README
> index 40a61f94315..7239dda257e 100644
> --- a/README
> +++ b/README
> @@ -40,7 +40,7 @@ COMMANDS
>    ima_fix [-t fdsxm] path
>    ima_clear [-t fdsxm] path
>    sign_hash [--veritysig] [--key key] [--pass=<password>]
> - hmac [--imahash | --imasig ] file
> + hmac [--imahash | --imasig] [--hmackey key] file
>   
>   
>   OPTIONS
> @@ -82,6 +82,7 @@ OPTIONS
>         --ignore-violations ignore ToMToU measurement violations
>         --verify-sig   verify the file signature based on the file hash, both
>                        stored in the template data.
> +      --hmackey      path to symmetric key (default: /etc/keys/evm-key-plain)
>     -v                 increase verbosity level
>     -h, --help         display this help and exit
>   
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 7a3ffd7c823..8caf9bd83fb 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1417,7 +1417,8 @@ static int cmd_hmac_evm(struct command *cmd)
>   			return err;
>   	}
>   
> -	return hmac_evm(file, "/etc/keys/evm-key-plain");
> +	return hmac_evm(file, imaevm_params.hmackeyfile ? :
> +			"/etc/keys/evm-key-plain");
>   }
>   
>   static int ima_fix(const char *path)
> @@ -2873,6 +2874,9 @@ static void usage(void)
>   		"      --engine e     preload OpenSSL engine e (such as: gost) is deprecated\n"
>   #endif
>   		"      --ignore-violations ignore ToMToU measurement violations\n"
> +#ifdef DEBUG
> +		"      --hmackey      path to symmetric key (default: /etc/keys/evm-key-plain)\n"
> +#endif
>   		"  -v                 increase verbosity level\n"
>   		"  -h, --help         display this help and exit\n"
>   		"\n"
> @@ -2902,7 +2906,7 @@ struct command cmds[] = {
>   	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
>   	{"sign_hash", cmd_sign_hash, 0, "[--veritysig] [--key key] [--pass[=<password>]]", "Sign hashes from either shaXsum or \"fsverity digest\" output.\n"},
>   #ifdef DEBUG
> -	{"hmac", cmd_hmac_evm, 0, "[--imahash | --imasig ] file", "Sign file metadata with HMAC using symmetric key (for testing purpose).\n"},
> +	{"hmac", cmd_hmac_evm, 0, "[--imahash | --imasig] [--hmackey key] file", "Sign file metadata with HMAC using symmetric key (for testing purpose).\n"},
>   #endif
>   	{0, 0, 0, NULL}
>   };
> @@ -2944,6 +2948,7 @@ static struct option opts[] = {
>   	{"keyid-from-cert", 1, 0, 145},
>   	{"veritysig", 0, 0, 146},
>   	{"hwtpm", 0, 0, 147},
> +	{"hmackey", 1, 0, 148},
>   	{}
>   
>   };
> @@ -3189,6 +3194,9 @@ int main(int argc, char *argv[])
>   		case 147:
>   			hwtpm = 1;
>   			break;
> +		case 148:
> +			imaevm_params.hmackeyfile = optarg;
> +			break;
>   		case '?':
>   			exit(1);
>   			break;
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 78e7ed5e89d..18d7b0e447e 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -221,6 +221,7 @@ struct libimaevm_params {
>   	const char *keypass;
>   	uint32_t keyid;		/* keyid overriding value, unless 0. (Host order.) */
>   	ENGINE *eng;
> +	const char *hmackeyfile;
>   };
>   
>   struct RSA_ASN1_template {

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
