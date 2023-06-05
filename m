Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71160722E69
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFESOn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 14:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFESOn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 14:14:43 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7764D9
        for <linux-integrity@vger.kernel.org>; Mon,  5 Jun 2023 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685988880; bh=6YTz4vz1BHET4LurY3x5Pj2ZbbOnU2SfqE+1bcyTl3Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WuS1E6hJTBpR0tP1pTwZgcEvLHUnS1vRR6ZQ9jJfkwZ3+RNXTuM3gzZJ3Tts5RQR1hae4q3MzXSbQBAtIwbTlqdZ229h3NRpp9FPDL4gfDJ0IWrmGrf+sC4W4SoHIGl7l5Y8lipqmcT2KyQc/KJRdEbCr9Jy7XbH59bB/yS9XTQSzJmLVwiTye+PbDNYsZ7diCJf6RSiQ9H3e7LdVGEXjQM2C3YJHETM8fpXoqZYsICWca4c/KFUOiiAKjIi5m4Xe2b9HOPqQignKE9pUcj/DHUcdd171Se+0bMt1FzxKrMg+/060heJ8kS5LNw0yKFFUWVQUZgrzzxlXpFIQRXBbQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685988880; bh=UiJ6zfA0oAI8o+Nz2vHilV711Ob5OV6/SqaXj6p2sWO=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PODbOqrrK0qTsIIUpIX4aoGEUTnI/frnWYM+5UvfFlxxOjY0crP+lDzB9bebYz7l46ixhr2uDYGyW/hAEqllAHu4Sa5lUUI+6zB3IoRVf29eFgjXBxzenxsIcr8n8bP9ylLbAvCjLFJDTISmU6OkA4A57aZUXv85E27enuaumPCbktvDqi7QW3MydM5FLUUcekHPvcZxSjxwI9uD7aH/LLEIZJcp1Q8R3gX3SHrkOU4GFPVChEBOCg7J/k+6JAcYRz/jESZsqVJZZ7vxf2jNG3AgM6mEbcq9BwpBgzrM+YsyOrlmtqK9UWgDGzqcvhErIhFvZERFx48goQ+QYA4wUQ==
X-YMail-OSG: A1AshmsVM1mg3OKLP8XdzH3Dx0u27lQR7Kslq.4.NDlLkQxRNSs0.CkWVU_q7kz
 tz5Jy34U1ERt1p1EmREsQUkDwQXbMwZpTtSMyoYTQCY3gGHpu6KePwivLmj85afubURn_6.Iyd85
 td3.sCl2P38uk9r9n2cFE1joQ2DZmG9ravP8MQr1RYSQpKBvNr0KhUZwZMujhQXOvYxRG9MCkB9Z
 _zu2VpZHf_AG_s.LnXO_EhARi3P0r4Jvk77YOXW6h6M59GaK1ErnB.BXLKqg68bsmPZec9ngyf.w
 4NTcMZh3jBOtTO2Kd8l0v0etyKrS1wt3cs7rNwGu7orrhlo.s0mHxor6QTPmc8XZmVBho4Xv2iP0
 HwVFYGHltKIOxwQh_MzoqadUh8yOaY4AE_KOPPxzY__A8cFqqiY8LHEVyEzRp3HeHwNBADbUaYm4
 9RWXr5AQmkRGXfZsaOUMf1FGeD4gqfc0BYF.HgYdp.MXK5wxXG_Ze3XCP5bHOThjl8ywbgHlRXhd
 maXc0qzQzJeHLnq5tROD3v99c8xkQYzz5ljIfMIQtBD0yB4xz_TAxIoGBrXLVVyxKG5S0ZCquAM2
 tzfLtagOsak5M8ZvVPl2hnuP4WvAffb8.BPkvgxiPPy.BqHrbX6PEtXmH1BEsG09hppKVE_HUbNy
 xQG70fKVFgENOEQd33E82.nnRnIPrIiKitE4VmRo9f6xbxhemDb53pdWyjzedWOcGwUijhdDFZwu
 gM_HoO36XNvsGe1XcTWWLAJMNJ13i9Jykuc5AFbP0TGfK7aEwPeduTiU61t4b6QybcYNjXhoeEuH
 6O7hIkVBbT6fkHNhKWXHsnRlOsjlG4TJGsBjCKKVIyCMTDA3amyv3_jUU2biSgH2hV3AoSJ8O7vx
 5H7HnCRpWW409nlBlPfBwqdEgG38X5IrulBatR3Fv.ErhRlOmnvE2de0_uucgkIZFZpDnoROE6D_
 1JD_zPOIpbRCCPPhYVy3Ksf149AC2FlF8SBKgIj6RJnGwsordeOz7mnF1IJFJrMdjI3Fss1BtMMt
 PRIjZEDK2adh9j1zZ.ylJinXyeygJxnSaZlP1TucstMcBrmTSIjs_1fF2B8p_4nNYJEnaDcGhpSs
 ECN_WtXR_WRZ3HlLIgM6UjwiRiUUI8Pdbw7dGvI7OW4h8gaPo2g_5VQjhq8466bGrf6dcDEZDCjB
 t0qhbl0gS2R0u21w9.kJQiHpS4ovzcmPJcACLrQUmqLDluxT06WjhULGyZXAaOdmiZvBRzv3er2A
 OVb4EoQ7VORkGZJ_J_W.lN_vWWG4lxJozJ2xGj3OP7T1.S0CA8lPz7SzK5lQjRXfDcXOmdjSQTUU
 COGFWtqn.mN.oroYzFsTzblQMoYBUfkKZ1uVioGsWTbPywjjC7M12zFwRfUZNljEm0lLkY6cd3Rl
 4vq48qvgleMu_OipC3I6yMUc7fJGPETw_CdFdssTncS8vqMT9fCg9gwrSKVXmlONKVnES64FeoZU
 uIyag2KhJUSGkMPGGZVn_0f82aTQyTxaheAgNzpO_e8dhPrBB9JNdBVTOLJ_.QmSESZ5Z4xb9S4o
 isIf7Ir_9pmgDPEKB6ptIy1TJO_I29HQ4sbH18BXzcQOkC6puzuezYpAiU_SX4tCcLBJA0InC3m3
 EykldWUxtLZRKsmMA0jQAqBIsdEcxS81gayoynShW8kSq5NGrOrEv7WO5I02oVb3oyq7zygWrymW
 JfAp7UpVaCC1YZTe4eWMgRWShonBES5j84nMkpafLiAQ_gutHCQSYKffM0..Av.UxEnINTU4Z5.P
 i3wJ8EGPS1pFZ9YpBppKEgXFa_n.TJ.f8Hx0Gklu3N9p3tDD.Z.JUstxXp1eONUsl5nrK9do0CQD
 IxoezlgNCm8GKg49uR3qopNQT3yQt6ljQ4AE6LDufz7sMA4Xc0HhSTudLE2G8BOaTI99.j69ZCk0
 wTqSkGWL1IBnZvfmOET.WCIyjPYJQ1kYcaQkIClsZvOm35O7MlUcNVptK4yhaQO711B8BN3ODKEj
 AwSAvAUAibzYgHEjzdcsHezyi8U7RGjTxjcURshdeC91dhxTkkaqATof1HPuuufS575Tuq2Hc2h5
 Y6RdM7lL2f8ptou0WIRMFFNhIzSVNZ.KjL8MXBYG8Sy9Ryyuhs709M0CrRNpktXkTwuiJT.Qbgty
 c37m3Kr_gd5JZiwwrJJXGwfvbXdX.NTCEroHQ8BRKsXL_bO_AaQ6zdppRN29TNVfc7xbwA_lktZ5
 C1WNqxv53bNcaUAtkIlWoxSi1.h2htCOz_JQBJeh9e2G.3.ihXAqZSD8Fr5gsDS9hSJikFFapkMv
 5Js9SLEHO
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 704eb42c-617e-478f-b694-e2c8e3103d4e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 5 Jun 2023 18:14:40 +0000
Received: by hermes--production-ne1-574d4b7954-6wwdb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2a9659aa2c06831bd15fe68ce71358e6;
          Mon, 05 Jun 2023 18:14:35 +0000 (UTC)
Message-ID: <108dac7a-2f1e-b097-c1a6-00878b388ff0@schaufler-ca.com>
Date:   Mon, 5 Jun 2023 11:14:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 ima-evm-utils 3/4] Add --hmackey option for evmctl
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230605165554.1965238-1-roberto.sassu@huaweicloud.com>
 <20230605165554.1965238-4-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230605165554.1965238-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/5/2023 9:55 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add the --hmackey option

At first glance I read this as "hackey", as in the option is a hack.
The name you have is the obvious choice, but it caught my attention
for the wrong reason. 

> , to specify an alternate path for the file
> containing the HMAC key. By default evmctl looks in
> /etc/keys/evm-key-plain.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  README       |  3 ++-
>  src/evmctl.c | 12 ++++++++++--
>  src/imaevm.h |  1 +
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/README b/README
> index 40a61f94315..7239dda257e 100644
> --- a/README
> +++ b/README
> @@ -40,7 +40,7 @@ COMMANDS
>   ima_fix [-t fdsxm] path
>   ima_clear [-t fdsxm] path
>   sign_hash [--veritysig] [--key key] [--pass=<password>]
> - hmac [--imahash | --imasig ] file
> + hmac [--imahash | --imasig] [--hmackey key] file
>  
>  
>  OPTIONS
> @@ -82,6 +82,7 @@ OPTIONS
>        --ignore-violations ignore ToMToU measurement violations
>        --verify-sig   verify the file signature based on the file hash, both
>                       stored in the template data.
> +      --hmackey      path to symmetric key (default: /etc/keys/evm-key-plain)
>    -v                 increase verbosity level
>    -h, --help         display this help and exit
>  
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 7a3ffd7c823..8caf9bd83fb 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1417,7 +1417,8 @@ static int cmd_hmac_evm(struct command *cmd)
>  			return err;
>  	}
>  
> -	return hmac_evm(file, "/etc/keys/evm-key-plain");
> +	return hmac_evm(file, imaevm_params.hmackeyfile ? :
> +			"/etc/keys/evm-key-plain");
>  }
>  
>  static int ima_fix(const char *path)
> @@ -2873,6 +2874,9 @@ static void usage(void)
>  		"      --engine e     preload OpenSSL engine e (such as: gost) is deprecated\n"
>  #endif
>  		"      --ignore-violations ignore ToMToU measurement violations\n"
> +#ifdef DEBUG
> +		"      --hmackey      path to symmetric key (default: /etc/keys/evm-key-plain)\n"
> +#endif
>  		"  -v                 increase verbosity level\n"
>  		"  -h, --help         display this help and exit\n"
>  		"\n"
> @@ -2902,7 +2906,7 @@ struct command cmds[] = {
>  	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
>  	{"sign_hash", cmd_sign_hash, 0, "[--veritysig] [--key key] [--pass[=<password>]]", "Sign hashes from either shaXsum or \"fsverity digest\" output.\n"},
>  #ifdef DEBUG
> -	{"hmac", cmd_hmac_evm, 0, "[--imahash | --imasig ] file", "Sign file metadata with HMAC using symmetric key (for testing purpose).\n"},
> +	{"hmac", cmd_hmac_evm, 0, "[--imahash | --imasig] [--hmackey key] file", "Sign file metadata with HMAC using symmetric key (for testing purpose).\n"},
>  #endif
>  	{0, 0, 0, NULL}
>  };
> @@ -2944,6 +2948,7 @@ static struct option opts[] = {
>  	{"keyid-from-cert", 1, 0, 145},
>  	{"veritysig", 0, 0, 146},
>  	{"hwtpm", 0, 0, 147},
> +	{"hmackey", 1, 0, 148},
>  	{}
>  
>  };
> @@ -3189,6 +3194,9 @@ int main(int argc, char *argv[])
>  		case 147:
>  			hwtpm = 1;
>  			break;
> +		case 148:
> +			imaevm_params.hmackeyfile = optarg;
> +			break;
>  		case '?':
>  			exit(1);
>  			break;
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 78e7ed5e89d..18d7b0e447e 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -221,6 +221,7 @@ struct libimaevm_params {
>  	const char *keypass;
>  	uint32_t keyid;		/* keyid overriding value, unless 0. (Host order.) */
>  	ENGINE *eng;
> +	const char *hmackeyfile;
>  };
>  
>  struct RSA_ASN1_template {
