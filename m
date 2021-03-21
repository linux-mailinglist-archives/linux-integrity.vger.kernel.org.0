Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A50B3434BC
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Mar 2021 21:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhCUUqt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Mar 2021 16:46:49 -0400
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:37857
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231219AbhCUUqi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Mar 2021 16:46:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9k6ZrtKMZTp7lpyHVUM3ZZbWB3S7+7JvteSrU4hIm3CDP28tt4hjCDmxTsUpEqCrKfRaTuxpWJ7qpnji1mssUalKi/FaFHinl3gBjT+Z3YIJEpL2zub1tF1L0IKkb+29t8qDnc4mnhA561F1HU0iK54ycMha6AN/+jvgaxbQ+6nIi8XfZR8iP4YS93N8cNkbTmme6xiTvOaRey1mPCx61MumevjFaO10bkm8eZTbkD61Enb2XVng29XKZ9SNFr4f+/esIXrPLXwZnDEvHaDn7OC7xqhnLo2ShD2y6xTqk3qbjOtEWcTtscZdhAR8/2/qKk82Wi4lCWojH3uVoPDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ETL+izj7TRywpU+yTGD3wd89O6uJKEGypBwrsvEz0=;
 b=b1ouB4Mrs3WVDpDGaL5ZjzJzzPja6jL255LWqojzHs974AZV1hbpKeOdlr42cxl60E7Q3xWuoofJDSTQj8ZxONVITwQP1P+daG3thdrWZvL+b2v0ForJfy6x1NIriaZNjhV1ASiNBBBxKP/oH7cAG863G1Ai+FmVIs7DkHlwZ1Cu8T1rMZx2H6DStN9rWMn0o4zRw1jyhXdWWS2FaoL3Yo5E0KpaW0aHNuOgJd0HFa2dOxoFijvuEhKu1KhB6cFBQLekCjDLYtD8Zo2sj1pzXEf27o3Pfkv95BRPwwY07iogs6jAKRHHsJXYu3aIzbXIkFWiQSna+M1f5PRyCx36Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ETL+izj7TRywpU+yTGD3wd89O6uJKEGypBwrsvEz0=;
 b=gKtBlIdr5ZmikQH+ChZqKcpoZmYTQTI+B0/f4Y0u10T1fONljDvXF5wmxWrEqzs7PF+QVzF6dFPVxXkerq6Lc6NkazEIwNL9VcygEPsntH65+WddLmjP1tbgbhWl0jwUR+8IKLaTeG6wqRDNjDAvn3JkWlhnChhRVxGTgknOz28=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4038.eurprd04.prod.outlook.com (2603:10a6:209:44::24)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 20:46:35 +0000
Received: from AM6PR04MB4038.eurprd04.prod.outlook.com
 ([fe80::ec5b:262e:8c27:c742]) by AM6PR04MB4038.eurprd04.prod.outlook.com
 ([fe80::ec5b:262e:8c27:c742%3]) with mapi id 15.20.3955.024; Sun, 21 Mar 2021
 20:46:35 +0000
Subject: Re: [PATCH v1 1/3] crypto: caam - add in-kernel interface for blob
 generator
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <420d2319e533ac97965fb826a70bdb023af2a844.1615914058.git-series.a.fatoum@pengutronix.de>
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <76cd2a74-f522-34c0-eb8c-3047e3cab5cd@nxp.com>
Date:   Sun, 21 Mar 2021 22:46:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <420d2319e533ac97965fb826a70bdb023af2a844.1615914058.git-series.a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.97.206.147]
X-ClientProxiedBy: AM0PR02CA0080.eurprd02.prod.outlook.com
 (2603:10a6:208:154::21) To AM6PR04MB4038.eurprd04.prod.outlook.com
 (2603:10a6:209:44::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.213] (78.97.206.147) by AM0PR02CA0080.eurprd02.prod.outlook.com (2603:10a6:208:154::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 20:46:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8785e98-4a43-4039-f84d-08d8ecaa6a82
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB61825B06FF4952E44C7ADBE898669@AM6PR04MB6182.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7a7HdIEdcJkLPG7Of1AdwPkzkzdUHW7XXLEoTt9pBva3AAwIDz9CprH99JjxDIulh129eaue6WFCLukF2R8En6Gtq7Zgj2LEaFySNuiAO8KR9Epvht7vCZTEJLCLryYN8ezsTnyx5euB4jNxIQhmemcOBFAncIQw5lzlK+vqmfmI8FvmTzn+y7mmXgy/bvX+CI3as9dXcFkstt9Y2cqM9SJxbViy6peL0UAWZAzxBtKwW3lOKCfaaOfKxPKEyMPHa/z4KwC0DXcqmvcF8hHIMYIhNsgLpaqnKA1jAF3w14eKwxMGpLxWMgKriINS7nZnHH79rnbjClemMDefIp3OI1nWCPT4krAszf8BFXfITFTEDyj8wi+CLiqLGTAWQazn2pl4U4OrpYc1DV/nkvXorxX13j4HNuZjvrjPvfpaMrcW+gqefexwfRd3V7XnYmvmgctYEkzZWCuuWNJp9K7GF4mNwJW2/Kko6xw+pApELUz6jmXVLvBFrYHnQEXrSmtHv0lXtLYsE7vheLgTPPRvNrBBonoApo/dQkMt9xY76EGGVSDg8Vq+qplNpAf0TULBdvYYYKXhmXNLhVYsqGvkG29hW1sFa4FocIZoWh35CZo2Uxt47Clct+fRA/5ZAgddt4I/my+BRqZbb8bsaCno3ADO+M/Cnmq7cWcXZ/Tfl5FerpUIRtiGh5fBQZnlx9zVjjGUY4rgvwR+fD5xvnWkh6L+vxiq6LPstsW01QWmlZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(86362001)(110136005)(6486002)(956004)(2616005)(38100700001)(5660300002)(54906003)(186003)(66556008)(16526019)(66946007)(66476007)(316002)(83380400001)(8936002)(52116002)(26005)(31696002)(16576012)(2906002)(7416002)(31686004)(8676002)(36756003)(4326008)(478600001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R2IxSTZjZWl4cGloeDhZNi9UaGRTcTRtcFBEclBtaU0vWHBmN1p6ZDd0a2Rx?=
 =?utf-8?B?VDV4Y3JEOEtuT3l2c1FTVThRd25tWXJaNmNoamtQMU5CcEVYTmZVTnFBQ00r?=
 =?utf-8?B?M0dqazB5Q3NDSzJnZlNBazRmd0wrTGN0NU9rSG8vZUQxdFA4aFcxMThVYXox?=
 =?utf-8?B?a0dSWXlNZmowanJndHB5K2owbEFZczdvYUt3LzZSclBjVWFoRnlTK3NEa1pl?=
 =?utf-8?B?Wk10SnJUWmJhcllIZUNOUWtucm55b3FhRmEydjNGTGs0cWRBd2IzVlhGT2d3?=
 =?utf-8?B?Tk1jOEplVDJMVldTajN2OHd0NzRqWmRYMzVPU01sK0EvWjRNLy96N3cycURs?=
 =?utf-8?B?cUVGd04xbk9lb1RDbVZ6S3p0S2laV1dHOW4rb2ZGZHFhY1JyMGsra3AzMnZ6?=
 =?utf-8?B?ZDNLRXBCSjYyaEZZcW9QZXl2Uy96cjQ1S21kYmtzZWNrRm05SE5PbVh2M3B6?=
 =?utf-8?B?dzhLc2d0bHNvNk96TGZ4YWdkelVGaTREbU5qbERya0NuOVVGNmZFcENvR1pF?=
 =?utf-8?B?OTRHUUVNMG1pbW9EL0lWZC85OFNLZytDZ3BoRGphYkhXMFhMK0w4ZVFieTh4?=
 =?utf-8?B?RnFHRGs4UVlVWDV4em1MYkxEV2lwZUVJUzQrcjNtc2ZUblNodngxRi80dENZ?=
 =?utf-8?B?WkQ2aC92L09FQm5FT2hLUmVwRE0xMUdPSVJyaWFVSzJhYnBETEFJU3cvWjNq?=
 =?utf-8?B?bHJVcy9tWDZ3U3BZMjRjMm04OXoyRUFGZFRNenJCWVh5Q0ljM0ZDNlpsaUFB?=
 =?utf-8?B?ZkpWNTlSWlNKVm0wd1BHdXR0T1VYei9FWkxzWUJUbXdJdEZMNFgyN1ozUTlN?=
 =?utf-8?B?Y3ZDTmxIRjJnUmFQOUVoYUxmNFUzbjlTdXE4a0RQZTJiSGpqZGE3YU9DeGVm?=
 =?utf-8?B?V3RTS3Q0cW5TQkZPb3FOVjZGVnVDWW5NTzZYY3RnZzQ3bldGMWI4R0YzY3hZ?=
 =?utf-8?B?eG9paWcydk9laTFzMDRqQzNqaUwwQjIzQ3R2RXl6enpuQml2N21qK2pOck5H?=
 =?utf-8?B?bUYvN3pabDJXcXBCSUJ6R0F2SGRNMVAyYW0wNGZZRFhGeWZ2aG1lYlZYZUxj?=
 =?utf-8?B?b2w4aWxYYmg4MzdPalZEcjdWU3IrckluQ1p0cU1FMFQzZFdreUFRRFpvL0VF?=
 =?utf-8?B?eEZtRE5oSWc5b0s1S3I0ZEdkTnJzWTFsdERRcU1IUzVZUkhKSEFaRDk4REZL?=
 =?utf-8?B?VGdaSVNjUHVzK1VsL3M1ZUgyRnAxcTVTZ3pxb0J2ejRDSU5NLzVlUEhiamdE?=
 =?utf-8?B?aE5rVm1JdUdkT1V4d3RsMElHVFcvNjNJeHNvSDBjbmV5b1k1amdzcUlqNXhL?=
 =?utf-8?B?TmtLS3J6Y2l2Tks4cDNIUDlGQjF2S0VrbERvVzY2SzFBK3I2TTQ5UXFNM2d3?=
 =?utf-8?B?MUxDN2JOUmZmRE1uUzhxSzN3Vm5GSlhrMmQzSndhVXlvTGhTa0d2RGVlbGNr?=
 =?utf-8?B?MGxibkhzL1lxaUEyNFBKaUVLM3ljVjhxU2hBV1JhRERIaXY5QnRNRVJuT2pM?=
 =?utf-8?B?ZWpuM0R4WkZFcCtpbHZRcksyTEllVkxRVnFrd2hFZjlia09DMmVxOUZkdkN1?=
 =?utf-8?B?YmI5Q05BSW9ENkFUSEZmVFBDOTMrMlhRR21tM3I0UFJiL1JRZzBNTDdzQkJ3?=
 =?utf-8?B?ODl2QytVMVZpNkRMODZHanVjREJwQ1c0dnIvQzJkZCt0SHVCOGI0bmJHZEU1?=
 =?utf-8?B?dzZFa1ZMVCtLYmRWWkN0NVBITFcxNFhORmdML2xUYlhIVm5lNTRpcVc0QW1G?=
 =?utf-8?Q?KYWvPPD+y7PfkPdlPOGemLEeFaaE99UyvyiDLot?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8785e98-4a43-4039-f84d-08d8ecaa6a82
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 20:46:35.4685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYu00Vjusc9J6YTkiyNV5DJZY/MwZHcM6pIBekxN4jLSt8Ho5cruAIlEIvKPO6l5gMM/h9G4pQQJ1UoC9odXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/16/2021 7:01 PM, Ahmad Fatoum wrote:
> +int caam_encap_blob(struct caam_blob_priv *priv, const char *keymod,
> +		    void *input, void *output, size_t length)
> +{
> +	u32 *desc;
> +	struct device *jrdev = &priv->jrdev;
> +	dma_addr_t dma_in, dma_out;
> +	struct caam_blob_job_result testres;
> +	size_t keymod_len = strlen(keymod);
> +	int ret;
> +
> +	if (length <= CAAM_BLOB_OVERHEAD)
> +		return -EINVAL;
> +
> +	desc = caam_blob_alloc_desc(keymod_len);
> +	if (!desc) {
> +		dev_err(jrdev, "unable to allocate desc\n");
> +		return -ENOMEM;
> +	}
> +
> +	dma_in = dma_map_single(jrdev, input, length - CAAM_BLOB_OVERHEAD, DMA_TO_DEVICE);
> +	if (dma_mapping_error(jrdev, dma_in)) {
> +		dev_err(jrdev, "unable to map input DMA buffer\n");
> +		ret = -ENOMEM;
> +		goto out_free;
> +	}
> +
> +	dma_out = dma_map_single(jrdev, output, length,	DMA_FROM_DEVICE);
> +	if (dma_mapping_error(jrdev, dma_out)) {
> +		dev_err(jrdev, "unable to map output DMA buffer\n");
> +		ret = -ENOMEM;
> +		goto out_unmap_in;
> +	}
> +
> +	/*
> +	 * A data blob is encrypted using a blob key (BK); a random number.
> +	 * The BK is used as an AES-CCM key. The initial block (B0) and the
> +	 * initial counter (Ctr0) are generated automatically and stored in
> +	 * Class 1 Context DWords 0+1+2+3. The random BK is stored in the
> +	 * Class 1 Key Register. Operation Mode is set to AES-CCM.
> +	 */
> +
> +	init_job_desc(desc, 0);
> +	append_key_as_imm(desc, keymod, keymod_len, keymod_len,
> +			  CLASS_2 | KEY_DEST_CLASS_REG);
> +	append_seq_in_ptr(desc, dma_in, length - CAAM_BLOB_OVERHEAD, 0);
> +	append_seq_out_ptr(desc, dma_out, length, 0);
In case length is known to be < 2^16, it's recommended to use instead
append_seq_in_ptr_intlen, append_seq_out_ptr_intlen.

> +	append_operation(desc, OP_TYPE_ENCAP_PROTOCOL | OP_PCLID_BLOB);
> +
> +	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
> +			     DUMP_PREFIX_ADDRESS, 16, 1, input,
> +			     length - CAAM_BLOB_OVERHEAD, false);
> +	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
> +			     DUMP_PREFIX_ADDRESS, 16, 1, desc,
> +			     desc_bytes(desc), false);
> +
> +	testres.err = 0;
> +	init_completion(&testres.completion);
> +
> +	ret = caam_jr_enqueue(jrdev, desc, caam_blob_job_done, &testres);
> +	if (ret == -EINPROGRESS) {
> +		wait_for_completion(&testres.completion);
> +		ret = testres.err;
> +		print_hex_dump_debug("output@"__stringify(__LINE__)": ",
> +				     DUMP_PREFIX_ADDRESS, 16, 1, output,
> +				     length, false);
> +	}
> +
> +	dma_unmap_single(jrdev, dma_out, length, DMA_FROM_DEVICE);
> +out_unmap_in:
> +	dma_unmap_single(jrdev, dma_in, length - CAAM_BLOB_OVERHEAD, DMA_TO_DEVICE);
> +out_free:
> +	kfree(desc);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(caam_encap_blob);
> +
[...]
> diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
> new file mode 100644
> index 000000000000..7eea0f543832
> --- /dev/null
> +++ b/include/soc/fsl/caam-blob.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
> + */
> +
> +#ifndef __CAAM_BLOB_GEN
> +#define __CAAM_BLOB_GEN
> +
> +#include <linux/types.h>
> +
> +#define CAAM_BLOB_KEYMOD_LENGTH		16
The define isn't used here or on patch 3/3.

> +#define CAAM_BLOB_OVERHEAD		(32 + 16)
> +#define CAAM_BLOB_MAX_LEN		4096
> +
> +struct caam_blob_priv;
> +
> +/** caam_blob_gen_init - initialize blob generation
> + *
> + * returns either pointer to new caam_blob_priv instance
> + * or error pointer
> + */
> +struct caam_blob_priv *caam_blob_gen_init(void);
> +
> +/** caam_blob_gen_init - free blob generation resources
> + *
> + * @priv: instance returned by caam_blob_gen_init
> + */
> +void caam_blob_gen_exit(struct caam_blob_priv *priv);
> +
> +/** caam_encap_blob - encapsulate blob
> + *
> + * @priv:   instance returned by caam_blob_gen_init
> + * @keymod: string to use as key modifier for blob encapsulation
> + * @input:  buffer which CAAM will DMA from
> + * @output: buffer which CAAM will DMA to
Is it guaranteed that input, output can be DMA-mapped?

Horia
